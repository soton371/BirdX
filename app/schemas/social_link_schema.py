from pydantic import BaseModel

class SocialLinkRequest(BaseModel):
    platform: str 
    url: str

class SocialLinkResponse(SocialLinkRequest):
    id: int

    class Config:
        from_attributes = True


