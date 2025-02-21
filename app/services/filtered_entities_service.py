from fastapi import HTTPException, status, Response
from app.core import oauth2, utilities, app_redis
from app.models import filtered_entities_model
from app.schemas import filtered_entities_schema
from sqlalchemy.orm import Session


brands_db = filtered_entities_model.Brands
def brandCreateService(brand_req: filtered_entities_schema.BrandsRequest, db: Session):
    exist_brand = db.query(brands_db).filter(brand_req.name == brands_db.name).first()
    