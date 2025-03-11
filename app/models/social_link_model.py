from app.core.database import Base
from sqlalchemy import Column, String, Integer


class SocialLink(Base):
    __tablename__ = "social_links"

    id = Column(Integer, primary_key=True)
    platform = Column(String, unique=True, nullable=False)
    url = Column(String, unique=True, nullable=False)


