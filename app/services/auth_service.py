from fastapi import HTTPException, status, Response
from app.core import oauth2, utilities
from app.models import auth_model
from app.schemas import auth_schema
from sqlalchemy.orm import Session


def adminLoginService(payload: auth_schema.AdminLogin, db: Session, response: Response):
    exist_user = db.query(auth_model.Admin).filter(
        auth_model.Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    # Verify password
    if not utilities.verifyPassword(payload.password, exist_user.password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail=f'Incorrect password')

    # Generate access token
    access_token = oauth2.createAccessToken(email=exist_user.email)
    data = auth_schema.TokenOut(access_token=access_token).model_dump()

    # set refresh token in httpOnly cookie
    refresh_token = oauth2.createRefreshToken(email=exist_user.email)
    response.set_cookie(
        key="refresh_token",
        value=refresh_token,
        httponly=True,
        samesite="Lax"
    )

    return data


def sendOTPService(payload: auth_schema.SendOTP, db: Session):
    exist_user = db.query(auth_model.Admin).filter(
        auth_model.Admin.email == payload.email).first()
    if not exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'User with this {payload.email} invalid')

    password_sent = oauth2.sendOTPSmtp(payload.email)
    if not password_sent:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail=f'Failed to send OTP to this email {payload.email}')
    # set otp in redis    

