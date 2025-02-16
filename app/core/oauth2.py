
import random
import string
import smtplib
from email.message import EmailMessage
import jwt
from datetime import datetime, timedelta
from app.core import database, utilities, app_constants, config
from sqlalchemy.orm import Session
from fastapi import Depends, status, HTTPException
from fastapi.security import OAuth2PasswordBearer

from app.core.debug_print import debugPrint
from app.schemas import auth_schema
from app.models import auth_model


def generateOTP(length: int = 6)-> str | None:
    return ''.join(random.choices(string.digits, k=length))

def sendOTPSmtp(recipientMail: str, otp: str)->(str | None):
    try:
        smtpServer = smtplib.SMTP(
            config.settings.smtp_host, config.settings.smtp_port)
        smtpServer.starttls()
        smtpServer.login(config.settings.sender_email,
                         config.settings.send_otp_password)
        msg = EmailMessage()
        msg['Subject'] = app_constants.otp_mail_subject
        msg['from'] = config.settings.sender_email
        msg['to'] = recipientMail
        msg.set_content(f"Your one time password is: {otp}")
        smtpServer.send_message(msg)
        return otp
    except Exception as e:
        print(f"sendOTPSmtp e: {e}")
        return None


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


SECRET_KEY = config.settings.secret_key
ALGORITHM = config.settings.algorithm
ACCESS_TOKEN_EXPIRE_DAY = config.settings.access_token_expire_day
REFRESH_TOKEN_EXPIRE_DAY = config.settings.refresh_token_expire_day


def createAccessToken(email: str):
    expire = datetime.now(utilities.my_timezone) + \
        timedelta(days=ACCESS_TOKEN_EXPIRE_DAY)
    return jwt.encode({"email": email, "exp": expire}, SECRET_KEY, algorithm=ALGORITHM)


def createRefreshToken(email: str):
    expire = datetime.now(utilities.my_timezone) + \
        timedelta(days=REFRESH_TOKEN_EXPIRE_DAY)
    return jwt.encode({"email": email, "exp": expire}, SECRET_KEY, algorithm=ALGORITHM)


def verifyAccessToken(token: str, credential_exception) -> auth_schema.TokenData:
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        admin_email = payload.get('email')

        if admin_email is None:
            raise credential_exception

        token_data = auth_schema.TokenData(email=admin_email)
    except Exception as e:
        debugPrint(f"error verify_access_token: {e} line: {e.__traceback__}")
        raise credential_exception

    return token_data


def getCurrentUser(token: str = Depends(oauth2_scheme), db: Session = Depends(database.get_db)):
    credential_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                         detail=f"Could not validate credential", headers={"WWW-Authenticate": "Bearer"})

    verifyToken = verifyAccessToken(token, credential_exception)

    user = db.query(auth_model.Admin).filter(
        auth_model.Admin.email == verifyToken.email).first()

    if not user:
        raise credential_exception

    return user
