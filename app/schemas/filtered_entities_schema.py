from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr


class BrandsRequest(BaseModel):
    name: str

class BrandsResponse(BrandsRequest):
    id: int


    