from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr

# ===================== Brand =====================
class BrandsRequest(BaseModel):
    name: str

class BrandsResponse(BrandsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Brand =====================
    