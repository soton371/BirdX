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
    

# ===================== Processor Types =====================
class ProcessorTypesRequest(BaseModel):
    name: str

class ProcessorTypesResponse(ProcessorTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Processor Types =====================



# ===================== Processor Models =====================
class ProcessorModelsRequest(BaseModel):
    name: str

class ProcessorModelsResponse(ProcessorModelsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Processor Models =====================



# ===================== Generation Series =====================
class GenerationSeriesRequest(BaseModel):
    name: str

class GenerationSeriesResponse(GenerationSeriesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Generation Series =====================



# ===================== Display Types =====================
class DisplayTypesRequest(BaseModel):
    name: str

class DisplayTypesResponse(DisplayTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Display Types =====================

