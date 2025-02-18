from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr


class AdminLoginRequest(BaseModel):
    email: EmailStr
    password: str


class AdminLoginResponse(BaseModel):
    id: int
    email: EmailStr
    name: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class TokenDataResponse(BaseModel):
    access_token: str
    token_type: Optional[str] = "Bearer"


class TokenDataRequest(BaseModel):
    email: Optional[str] = None


class SendOTPRequest(BaseModel):
    email: EmailStr


class VerifyOTPRequest(SendOTPRequest):
    otp: str
