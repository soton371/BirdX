from pydantic import BaseModel, Field

class SocialLinkRequest(BaseModel):
    platform: str = Field(min_length=3)
    url: str = Field(min_length=3)

class SocialLinkResponse(SocialLinkRequest):
    id: int

    class Config:
        from_attributes = True


