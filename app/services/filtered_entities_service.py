from fastapi import HTTPException, status
from app.models import filtered_entities_model
from app.schemas import filtered_entities_schema
from sqlalchemy.orm import Session


# ===================== Brand =====================
brands_db = filtered_entities_model.Brands


def brandCreateService(brand_req: filtered_entities_schema.BrandsRequest, db: Session):
    new_brand = filtered_entities_model.Brands(**brand_req.model_dump())
    db.add(new_brand)
    db.commit()
    db.refresh(new_brand)


def getBrandsService(db: Session):
    query = db.query(brands_db)
    result = [
        filtered_entities_schema.BrandsResponse.model_validate(
            brand).model_dump()
        for brand in query.all()
    ]
    return result


def deleteBrandService(brand_id: int, db: Session):
    query = db.query(brands_db).filter(brand_id == brands_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Brand not found with id {brand_id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateBrandService(brand_id: int, brand_req: filtered_entities_schema.BrandsRequest, db: Session):
    query = db.query(brands_db).filter(brand_id == brands_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Brand not found with id {brand_id}')
    query.name = brand_req.name
    db.commit()
# ===================== End Brand =====================


# ===================== Processor Type =====================
processor_type_db = filtered_entities_model.ProcessorTypes


def createProcessorTypeService(req: filtered_entities_schema.ProcessorTypesRequest, db: Session):
    new_data = filtered_entities_model.ProcessorTypes(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getProcessorTypeService(db: Session):
    query = db.query(processor_type_db)
    result = [
        filtered_entities_schema.ProcessorTypesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteProcessorTypeService(id: int, db: Session):
    query = db.query(processor_type_db).filter(id == processor_type_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Processor type not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateProcessorTypeService(id: int, req: filtered_entities_schema.ProcessorTypesRequest, db: Session):
    query = db.query(processor_type_db).filter(
        id == processor_type_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Processor type not found with id {id}')
    query.name = req.name
    db.commit()

# ===================== End Processor Type =====================


# ===================== Processor Models =====================
processor_models_db = filtered_entities_model.ProcessorModels


def createProcessorModelService(req: filtered_entities_schema.ProcessorModelsRequest, db: Session):
    new_data = filtered_entities_model.ProcessorModels(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getProcessorModelsService(db: Session):
    query = db.query(processor_models_db)
    result = [
        filtered_entities_schema.ProcessorModelsResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteProcessorModelService(id: int, db: Session):
    query = db.query(processor_models_db).filter(id == processor_models_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Processor model not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateProcessorModelService(id: int, req: filtered_entities_schema.ProcessorModelsRequest, db: Session):
    query = db.query(processor_models_db).filter(
        id == processor_models_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Processor model not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Processor Models =====================


# ===================== Generation Series =====================
generation_series_db = filtered_entities_model.GenerationSeries


def createGenerationSeriesService(req: filtered_entities_schema.GenerationSeriesRequest, db: Session):
    new_data = filtered_entities_model.GenerationSeries(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getGenerationSeriesService(db: Session):
    query = db.query(generation_series_db)
    result = [
        filtered_entities_schema.GenerationSeriesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteGenerationSeriesService(id: int, db: Session):
    query = db.query(generation_series_db).filter(id == generation_series_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Generation/Series not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateGenerationSeriesService(id: int, req: filtered_entities_schema.GenerationSeriesRequest, db: Session):
    query = db.query(generation_series_db).filter(
        id == generation_series_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Generation/Series not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Generation Series =====================



# ===================== Display Types =====================
display_types_db = filtered_entities_model.DisplayTypes


def createDisplayTypesService(req: filtered_entities_schema.DisplayTypesRequest, db: Session):
    new_data = filtered_entities_model.DisplayTypes(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getDisplayTypesService(db: Session):
    query = db.query(display_types_db)
    result = [
        filtered_entities_schema.DisplayTypesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteDisplayTypesService(id: int, db: Session):
    query = db.query(display_types_db).filter(id == display_types_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Display type not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateDisplayTypesService(id: int, req: filtered_entities_schema.DisplayTypesRequest, db: Session):
    query = db.query(display_types_db).filter(
        id == display_types_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Display type not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Display Types =====================




# ===================== Special Features =====================
special_features_db = filtered_entities_model.SpecialFeatures


def createSpecialFeaturesService(req: filtered_entities_schema.SpecialFeaturesRequest, db: Session):
    new_data = filtered_entities_model.SpecialFeatures(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getSpecialFeaturesService(db: Session):
    query = db.query(special_features_db)
    result = [
        filtered_entities_schema.SpecialFeaturesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteSpecialFeaturesService(id: int, db: Session):
    query = db.query(special_features_db).filter(id == special_features_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Special feature not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateSpecialFeaturesService(id: int, req: filtered_entities_schema.SpecialFeaturesRequest, db: Session):
    query = db.query(special_features_db).filter(
        id == special_features_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Special feature not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Special Features =====================


# ===================== Ram Sizes =====================
ram_sizes_db = filtered_entities_model.RamSizes


def createRamSizesService(req: filtered_entities_schema.RamSizesRequest, db: Session):
    new_data = filtered_entities_model.RamSizes(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getRamSizesService(db: Session):
    query = db.query(ram_sizes_db)
    result = [
        filtered_entities_schema.RamSizesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteRamSizesService(id: int, db: Session):
    query = db.query(ram_sizes_db).filter(id == ram_sizes_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Ram size not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateRamSizesService(id: int, req: filtered_entities_schema.RamSizesRequest, db: Session):
    query = db.query(ram_sizes_db).filter(
        id == ram_sizes_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Ram size not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Ram Sizes =====================


# ===================== Ram Types =====================
ram_types_db = filtered_entities_model.RamTypes


def createRamTypesService(req: filtered_entities_schema.RamTypesRequest, db: Session):
    new_data = filtered_entities_model.RamTypes(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getRamTypesService(db: Session):
    query = db.query(ram_types_db)
    result = [
        filtered_entities_schema.RamTypesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteRamTypesService(id: int, db: Session):
    query = db.query(ram_types_db).filter(id == ram_types_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Ram type not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateRamTypesService(id: int, req: filtered_entities_schema.RamTypesRequest, db: Session):
    query = db.query(ram_types_db).filter(
        id == ram_types_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Ram type not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Ram Types =====================



# ===================== HDD =====================
hdd_db = filtered_entities_model.HDD


def createHDDService(req: filtered_entities_schema.HDDRequest, db: Session):
    new_data = filtered_entities_model.HDD(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getHDDService(db: Session):
    query = db.query(hdd_db)
    result = [
        filtered_entities_schema.HDDResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteHDDService(id: int, db: Session):
    query = db.query(hdd_db).filter(id == hdd_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'HDD not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateHDDService(id: int, req: filtered_entities_schema.HDDRequest, db: Session):
    query = db.query(hdd_db).filter(
        id == hdd_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'HDD not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End HDD =====================



# ===================== SSD =====================
ssd_db = filtered_entities_model.SSD


def createSSDService(req: filtered_entities_schema.SSDRequest, db: Session):
    new_data = filtered_entities_model.SSD(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getSSDService(db: Session):
    query = db.query(ssd_db)
    result = [
        filtered_entities_schema.SSDResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteSSDService(id: int, db: Session):
    query = db.query(ssd_db).filter(id == ssd_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'SSD not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateSSDService(id: int, req: filtered_entities_schema.SSDRequest, db: Session):
    query = db.query(ssd_db).filter(
        id == ssd_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'SSD not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End SSD =====================




# ===================== Graphics =====================
graphics_db = filtered_entities_model.Graphics


def createGraphicsService(req: filtered_entities_schema.GraphicsRequest, db: Session):
    new_data = filtered_entities_model.Graphics(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getGraphicsService(db: Session):
    query = db.query(graphics_db)
    result = [
        filtered_entities_schema.GraphicsResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteGraphicsService(id: int, db: Session):
    query = db.query(graphics_db).filter(id == graphics_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Graphics not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateGraphicsService(id: int, req: filtered_entities_schema.GraphicsRequest, db: Session):
    query = db.query(graphics_db).filter(
        id == graphics_db.id).first()
    if not query:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Graphics not found with id {id}')
    query.name = req.name
    db.commit()
# ===================== End Graphics =====================




# ===================== Display Sizes =====================
display_sizes_db = filtered_entities_model.DisplaySizes


def createDisplaySizesService(req: filtered_entities_schema.DisplaySizesRequest, db: Session):
    new_data = display_sizes_db(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getDisplaySizesService(db: Session):
    query = db.query(display_sizes_db)
    result = [
        filtered_entities_schema.DisplaySizesResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteDisplaySizesService(id: int, db: Session):
    query = db.query(display_sizes_db).filter(id == display_sizes_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Display sizes not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateDisplaySizesService(id: int, req: filtered_entities_schema.DisplaySizesRequest, db: Session):
    query = db.query(display_sizes_db).filter(display_sizes_db.id == id).first()
    
    if not query:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Display size not found with id {id}"
        )

    query.min_size = req.min_size
    query.max_size = req.max_size

    db.commit()
    db.refresh(query)
# ===================== End Display Sizes =====================

