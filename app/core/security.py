from sqlalchemy.orm import Session
from fastapi import Depends, status, HTTPException
from app.db.session import get_db
from app.features.auth.models import Admin
from app.features.auth.oauth2 import oauth2_scheme, verifyAccessToken


def getCurrentUser(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    credential_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                         detail=f"Could not validate credential", headers={"WWW-Authenticate": "Bearer"})

    verifyToken = verifyAccessToken(token, credential_exception)

    userAdmin = db.query(Admin).filter(
        Admin.email == verifyToken.email).first()

    if not userAdmin:
        raise credential_exception

    return userAdmin