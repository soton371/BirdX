from pydantic import BaseModel, Field


# ===================== Brand =====================
class BrandsRequest(BaseModel):
    name: str = Field(min_length=3)

class BrandsResponse(BrandsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Brand =====================
    

# ===================== Processor Types =====================
class ProcessorTypesRequest(BaseModel):
    name: str = Field(min_length=3)

class ProcessorTypesResponse(ProcessorTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Processor Types =====================



# ===================== Processor Models =====================
class ProcessorModelsRequest(BaseModel):
    name: str = Field(min_length=3)

class ProcessorModelsResponse(ProcessorModelsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Processor Models =====================



# ===================== Generation Series =====================
class GenerationSeriesRequest(BaseModel):
    name: str = Field(min_length=3)

class GenerationSeriesResponse(GenerationSeriesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Generation Series =====================



# ===================== Display Types =====================
class DisplayTypesRequest(BaseModel):
    name: str = Field(min_length=3)

class DisplayTypesResponse(DisplayTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Display Types =====================


# ===================== Special Features =====================
class SpecialFeaturesRequest(BaseModel):
    name: str = Field(min_length=3)

class SpecialFeaturesResponse(SpecialFeaturesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Special Features =====================




# ===================== Ram Sizes =====================
class RamSizesRequest(BaseModel):
    name: str = Field(min_length=3)

class RamSizesResponse(RamSizesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Ram Sizes =====================


# ===================== Ram Types =====================
class RamTypesRequest(BaseModel):
    name: str = Field(min_length=3)

class RamTypesResponse(RamTypesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Ram Types =====================



# ===================== HDD=====================
class HDDRequest(BaseModel):
    name: str = Field(min_length=3)

class HDDResponse(HDDRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End HDD =====================



# ===================== SSD=====================
class SSDRequest(BaseModel):
    name: str = Field(min_length=3)

class SSDResponse(HDDRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End SSD =====================




# ===================== Graphics =====================
class GraphicsRequest(BaseModel):
    name: str = Field(min_length=3)

class GraphicsResponse(GraphicsRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Graphics =====================



# ===================== Display Sizes =====================
class DisplaySizesRequest(BaseModel):
    min_size: float = Field(min_length=2)
    max_size: float = Field(min_length=2)

class DisplaySizesResponse(DisplaySizesRequest):
    id: int

    class Config:
        from_attributes = True

# ===================== End Display Sizes =====================
