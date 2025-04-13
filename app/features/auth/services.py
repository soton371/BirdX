from fastapi import HTTPException, status, Response
from sqlalchemy.orm import Session
from app.features.auth.models import Admin
from app.features.auth import schemas
from app.features.auth import utilities
from app.features.auth.oauth2 import createAccessToken, createRefreshToken



def adminLoginService(payload: schemas.AdminLoginRequest, db: Session, response: Response):
    exist_user = db.query(Admin).filter(
        Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    # Verify password
    if not utilities.verifyPassword(payload.password, exist_user.password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail=f'Incorrect password')

    # Generate access token
    access_token = createAccessToken(email=exist_user.email)
    data = schemas.TokenDataResponse(
        access_token=access_token).model_dump()

    # set refresh token in httpOnly cookie
    refresh_token = createRefreshToken(email=exist_user.email)
    response.set_cookie(
        key="refresh_token",
        value=refresh_token,
        httponly=True,
        samesite="Lax"
    )

    return data



def sendOTPService(payload: schemas.SendOTPRequest, db: Session):
    exist_user = db.query(Admin).filter(
        Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    my_otp = utilities.generateOTP()
    
    store_otp = utilities.storeOTP(email=payload.email, otp=my_otp)
    if not store_otp:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to store OTP')

    otp_sent = utilities.sendOTPSmtp(recipientMail=payload.email, otp=my_otp)
    if otp_sent is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to send OTP to this email {payload.email}')






def verifyOTPService(payload: schemas.VerifyOTPRequest, db: Session):
    store_otp = utilities.getOTP(payload.email)
    if store_otp is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail='OTP expired or not found')

    if store_otp == payload.otp:
        utilities.deleteOTP(payload.email)
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail='Invalid OTP')
    access_token = createAccessToken(email=payload.email)
    data = schemas.TokenDataResponse(
        access_token=access_token).model_dump() 
    if not data:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                            detail='Internal server error')
    return data




def resetPasswordService(payload: schemas.ResetPasswordRequest, db: Session, current_user: Admin):
    exist_user = db.query(Admin).filter(
        Admin.email == current_user.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Invalid request')
    hashed_password = utilities.hashedPassword(password=payload.password)

    if hashed_password is None:
        raise HTTPException(status_code=status.HTTP_417_EXPECTATION_FAILED,
                            detail=f'Failed to generate password')
    exist_user.password = hashed_password
    db.commit()
