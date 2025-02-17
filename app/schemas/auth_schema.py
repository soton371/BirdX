from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr


class AdminLogin(BaseModel):
    email: EmailStr
    password: str
    


class AdminOut(BaseModel):
    id: int
    email: EmailStr
    name: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True


class TokenOut(BaseModel):
    access_token: str
    token_type: Optional[str] = "Bearer"


class TokenData(BaseModel):
    email: Optional[str] = None


class SendOTP(BaseModel):
    email: EmailStr

class VerifyOTP(SendOTP):
    otp: str

