from pydantic import BaseModel
from typing import Union


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


# ===================== Special Features =====================
class SpecialFeaturesRequest(BaseModel):
    name: str

class SpecialFeaturesResponse(SpecialFeaturesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Special Features =====================




# ===================== Ram Sizes =====================
class RamSizesRequest(BaseModel):
    name: str

class RamSizesResponse(RamSizesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Ram Sizes =====================


# ===================== Ram Types =====================
class RamTypesRequest(BaseModel):
    name: str

class RamTypesResponse(RamTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Ram Types =====================



# ===================== HDD=====================
class HDDRequest(BaseModel):
    name: str

class HDDResponse(HDDRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End HDD =====================



# ===================== SSD=====================
class SSDRequest(BaseModel):
    name: str

class SSDResponse(HDDRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End SSD =====================




# ===================== Graphics =====================
class GraphicsRequest(BaseModel):
    name: str

class GraphicsResponse(GraphicsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Graphics =====================



# ===================== Display Sizes =====================
class DisplaySizesRequest(BaseModel):
    min_size: float
    max_size: float

class DisplaySizesResponse(DisplaySizesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Display Sizes =====================
