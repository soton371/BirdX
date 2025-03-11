from pydantic import BaseModel, HttpUrl

class SocialLinkRequest(BaseModel):
    platform: str 
    url: HttpUrl

class SocialLinkResponse(SocialLinkRequest):
    id: int

    class Config:
        from_attributes = True


