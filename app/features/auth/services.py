from fastapi import HTTPException, status, Response
from sqlalchemy.orm import Session
from app.features.auth.models import Admin
from app.features.auth.schemas import AdminLoginRequest
from app.features.auth.utilities import verifyPassword



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