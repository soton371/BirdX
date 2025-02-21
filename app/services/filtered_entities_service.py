from fastapi import HTTPException, status
from app.models import filtered_entities_model
from app.schemas import filtered_entities_schema
from sqlalchemy.orm import Session
from sqlalchemy import func


# ===================== Brand =====================
brands_db = filtered_entities_model.Brands

def brandCreateService(brand_req: filtered_entities_schema.BrandsRequest, db: Session):
    if not brand_req.name.strip():
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail="Brand name cannot be empty.")
    
    exist_brand = db.query(brands_db).filter(
        func.lower(func.trim(brands_db.name)) == func.lower(func.trim(brand_req.name))
    ).first()
    

    if exist_brand:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f"Brand '{brand_req.name}' already exists.")

    new_brand = filtered_entities_model.Brands(**brand_req.model_dump())
    db.add(new_brand)
    db.commit()
    db.refresh(new_brand)


def getBrandsService(db: Session):
    query = db.query(brands_db)
    result = [
        filtered_entities_schema.BrandsResponse.model_validate(brand).model_dump()
        for brand in query.all()
    ]
    return result


def deleteBrandService(brand_id: int, db: Session):
    query = db.query(brands_db).filter(brand_id == brands_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'Brand not found with id {brand_id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateBrandService(brand_id: int, brand_req: filtered_entities_schema.BrandsRequest, db: Session):
    if not brand_req.name.strip():
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail="Brand name cannot be empty.")
    query = db.query(brands_db).filter(brand_id == brands_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'Brand not found with id {brand_id}')
    query.name = brand_req.name.strip()
    db.commit()

# ===================== End Brand =====================






# ===================== Processor Type =====================
processor_type_db = filtered_entities_model.ProcessorTypes

def createProcessorTypeService(req: filtered_entities_schema.ProcessorTypesRequest, db: Session):
    if not req.name.strip():
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail="Processor type name cannot be empty.")
    
    exist_data = db.query(processor_type_db).filter(
        func.lower(func.trim(processor_type_db.name)) == func.lower(func.trim(req.name))
    ).first()
    

    if exist_data:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f"Processor type '{req.name}' already exists.")

    new_data = filtered_entities_model.ProcessorTypes(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getProcessorTypeService(db: Session):
    query = db.query(processor_type_db)
    result = [
        filtered_entities_schema.ProcessorTypesResponse.model_validate(data).model_dump()
        for data in query.all()
    ]
    return result


def deleteProcessorTypeService(id: int, db: Session):
    query = db.query(processor_type_db).filter(id == processor_type_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'Processor type not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateProcessorTypeService(id: int, req: filtered_entities_schema.ProcessorTypesRequest, db: Session):
    if not req.name.strip():
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail="Processor type name cannot be empty.")
    query = db.query(processor_type_db).filter(id == processor_type_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'Processor type not found with id {id}')
    query.name = req.name.strip()
    db.commit()

# ===================== End Processor Type =====================

