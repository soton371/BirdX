from fastapi import HTTPException, status, Response
from sqlalchemy.orm import Session
from app.features.auth.models import Admin
from app.features.auth.schemas import AdminLoginRequest, TokenDataResponse, SendOTPRequest
from app.features.auth.utilities import verifyPassword, generateOTP, storeOTP, sendOTPSmtp
from app.features.auth.oauth2 import createAccessToken, createRefreshToken



def adminLoginService(payload: AdminLoginRequest, db: Session, response: Response):
    exist_user = db.query(Admin).filter(
        Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    # Verify password
    if not verifyPassword(payload.password, exist_user.password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail=f'Incorrect password')

    # Generate access token
    access_token = createAccessToken(email=exist_user.email)
    data = TokenDataResponse(
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



def sendOTPService(payload: SendOTPRequest, db: Session):
    exist_user = db.query(Admin).filter(
        Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    my_otp = generateOTP()
    
    store_otp = storeOTP(email=payload.email, otp=my_otp)
    if not store_otp:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to store OTP')

    otp_sent = sendOTPSmtp(recipientMail=payload.email, otp=my_otp)
    if otp_sent is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to send OTP to this email {payload.email}')
