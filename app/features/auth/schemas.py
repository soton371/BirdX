from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr, Field


class AdminLoginRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=6)


class AdminProfileResponse(BaseModel):
    id: int
    email: EmailStr
    name: Optional[str] = None
    image: Optional[str] = None
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

class ResetPasswordRequest(BaseModel):
    password: str = Field(min_length=6)