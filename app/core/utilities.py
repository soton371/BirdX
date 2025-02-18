
from passlib.context import CryptContext
import pytz
from typing import Optional


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hashedPassword(password: str) -> (str | None):
    try:
        return pwd_context.hash(password)
    except Exception as error:
        print(f'hashedPassword error: {error}')
        return None

def verifyPassword(plainPassword: str, hashedPassword: str) -> bool:
    return pwd_context.verify(plainPassword, hashedPassword)


def booleanValue(string_value: Optional[str]) -> Optional[bool]:
    try:
        boolean_mapping = {'true': True, 'false': False}
        boolean_value = boolean_mapping.get(string_value.lower(), None) 
        return boolean_value
    except Exception as error:
        print(f'booleanValue error: {error}')
        return None
    



my_timezone = pytz.timezone('Asia/Dhaka')
