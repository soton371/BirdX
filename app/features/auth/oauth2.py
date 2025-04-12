from sqlalchemy.orm import Session
from fastapi import Depends, status, HTTPException
from fastapi.security import OAuth2PasswordBearer
import jwt
from app.core.debug_print import debugPrint
from app.core.env_settings import settings
from datetime import datetime, timedelta
from app.core.utilities import my_timezone
from app.db.session import get_db
from app.features.auth.schemas import TokenDataRequest
from app.features.auth.models import Admin


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


SECRET_KEY = settings.secret_key
ALGORITHM = settings.algorithm
ACCESS_TOKEN_EXPIRE_DAY = settings.access_token_expire_day
REFRESH_TOKEN_EXPIRE_DAY = settings.refresh_token_expire_day


def createAccessToken(email: str) -> str:
    expire = datetime.now(my_timezone) + \
        timedelta(days=ACCESS_TOKEN_EXPIRE_DAY)
    return jwt.encode({"email": email, "exp": expire}, SECRET_KEY, algorithm=ALGORITHM)


def createRefreshToken(email: str) -> str:
    expire = datetime.now(my_timezone) + \
        timedelta(days=REFRESH_TOKEN_EXPIRE_DAY)
    return jwt.encode({"email": email, "exp": expire}, SECRET_KEY, algorithm=ALGORITHM)


def verifyAccessToken(token: str, credential_exception) -> TokenDataRequest:
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        admin_email = payload.get('email')

        if admin_email is None:
            raise credential_exception

        token_data = TokenDataRequest(email=admin_email)
        return token_data
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=400, detail="Token expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=400, detail="Invalid token")
    except Exception as e:
        debugPrint(f"error verify_access_token: {e} line: {e.__traceback__}")
        raise credential_exception


