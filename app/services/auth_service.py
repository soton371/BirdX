from fastapi import HTTPException, status, Response
from app.core import oauth2, utilities, app_redis
from app.models import auth_model
from app.schemas import auth_schema
from sqlalchemy.orm import Session


admin_db = auth_model.Admin
def adminLoginService(payload: auth_schema.AdminLoginRequest, db: Session, response: Response):
    exist_user = db.query(admin_db).filter(
        admin_db.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    # Verify password
    if not utilities.verifyPassword(payload.password, exist_user.password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail=f'Incorrect password')

    # Generate access token
    access_token = oauth2.createAccessToken(email=exist_user.email)
    data = auth_schema.TokenDataResponse(
        access_token=access_token).model_dump()

    # set refresh token in httpOnly cookie
    refresh_token = oauth2.createRefreshToken(email=exist_user.email)
    response.set_cookie(
        key="refresh_token",
        value=refresh_token,
        httponly=True,
        samesite="Lax"
    )

    return data


def sendOTPService(payload: auth_schema.SendOTPRequest, db: Session):
    exist_user = db.query(admin_db).filter(
        admin_db.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    my_otp = oauth2.generateOTP()
    if my_otp is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to generate OTP')

    store_otp = app_redis.storeOTP(email=payload.email, otp=my_otp)
    if not store_otp:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to store OTP')

    otp_sent = oauth2.sendOTPSmtp(recipientMail=payload.email, otp=my_otp)
    if otp_sent is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to send OTP to this email {payload.email}')


def verifyOTPService(payload: auth_schema.VerifyOTPRequest, db: Session):
    store_otp = app_redis.getOTP(payload.email)
    if store_otp is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail='OTP expired or not found')

    if store_otp == payload.otp:
        app_redis.deleteOTP(payload.email)
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail='Invalid OTP')
    access_token = oauth2.createAccessToken(email=payload.email)
    data = auth_schema.TokenDataResponse(
        access_token=access_token).model_dump() 
    if not data:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                            detail='Internal server error')
    return data


def resetPasswordService(payload: auth_schema.ResetPasswordRequest, db: Session, current_user: admin_db):
    exist_user = db.query(admin_db).filter(
        admin_db.email == current_user.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Invalid request')
    hashed_password = utilities.hashedPassword(password=payload.password)

    if hashed_password is None:
        raise HTTPException(status_code=status.HTTP_417_EXPECTATION_FAILED,
                            detail=f'Failed to generate password')
    exist_user.password = hashed_password
    db.commit()

