from passlib.context import CryptContext
import random
import string
from app.core import app_constants
from app.core.debug_print import debugPrint
from app.db.redis import redis_client
import smtplib
from email.message import EmailMessage
from app.core.env_settings import settings


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hashedPassword(password: str) -> (str | None):
    try:
        return pwd_context.hash(password)
    except Exception as error:
        print(f'hashedPassword error: {error}')
        return None


def verifyPassword(plainPassword: str, hashedPassword: str) -> bool:
    return pwd_context.verify(plainPassword, hashedPassword)

def generateOTP(length: int = 6) -> str | None:
    return ''.join(random.choices(string.digits, k=length))


def storeOTP(email: str, otp: str, ttl: int = 180)-> bool:
    try:
        redis_client.setex(f"{app_constants.redisOtpKey}:{email}", ttl, otp)
        return True
    except Exception as error:
        debugPrint(f"storeOTP error: {error}")
        return False

def getOTP(email: str | None)-> (str | None):
    if email is None:
        return None
    return redis_client.get(f"{app_constants.redisOtpKey}:{email}")

def deleteOTP(email: str):
    redis_client.delete(f"{app_constants.redisOtpKey}:{email}")


def sendOTPSmtp(recipientMail: str, otp: str) -> (str | None):
    try:
        smtpServer = smtplib.SMTP(
            settings.smtp_host, settings.smtp_port)
        smtpServer.starttls()
        smtpServer.login(settings.sender_email,
                         settings.send_otp_password)
        msg = EmailMessage()
        msg['Subject'] = app_constants.otp_mail_subject
        msg['from'] = settings.sender_email
        msg['to'] = recipientMail
        msg.set_content(f"Your one time password is: {otp}")
        smtpServer.send_message(msg)
        return otp
    except Exception as e:
        print(f"sendOTPSmtp e: {e}")
        return None