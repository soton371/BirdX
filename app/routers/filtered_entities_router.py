from fastapi import HTTPException, status, Depends, APIRouter, Response
from app.core import app_constants, oauth2
from app.core.debug_print import debugPrint
from app.schemas import filtered_entities_schema
from sqlalchemy.orm import Session
from app.core.app_response import ResponseFailed, ResponseSuccess
from app.core.database import get_db
from app.models import auth_model
from app.services import filtered_entities_service


router = APIRouter(
    prefix="",
    tags=['Filtered Entities']
)

# ===================== Brand =====================
@router.post(app_constants.brands)
async def brandCreate(brand_req: filtered_entities_schema.BrandsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.brandCreateService(brand_req=brand_req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The brand has been successfully created.")

    

@router.get(app_constants.brands)
async def getBrands(db: Session = Depends(get_db)):
        data = filtered_entities_service.getBrandsService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.brands}"+"/{brand_id}")
async def deleteBrand(brand_id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteBrandService(brand_id=brand_id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The brand has been successfully deleted.')

    


@router.patch(f"{app_constants.brands}"+"/{brand_id}")
async def updateBrand(brand_id: int, brand_req: filtered_entities_schema.BrandsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateBrandService(brand_id=brand_id, brand_req=brand_req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The brand has been successfully updated.')

    
# ===================== End Brand =====================






# ===================== Processor Type =====================
@router.post(app_constants.processor_types)
async def createProcessorTypes(req: filtered_entities_schema.ProcessorTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createProcessorTypeService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The processor type has been successfully created.")

    

@router.get(app_constants.processor_types)
async def getProcessorTypes(db: Session = Depends(get_db)):
        data = filtered_entities_service.getProcessorTypeService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.processor_types}"+"/{id}")
async def deleteProcessorTypes(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteProcessorTypeService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor type has been successfully deleted.')

    


@router.patch(f"{app_constants.processor_types}"+"/{id}")
async def updateProcessorTypes(id: int, req: filtered_entities_schema.ProcessorTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateProcessorTypeService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor type has been successfully updated.')

    
# ===================== End Processor Type =====================



# ===================== Processor Models =====================
@router.post(app_constants.processor_models)
async def createProcessorModels(req: filtered_entities_schema.ProcessorModelsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createProcessorModelService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The processor model has been successfully created.")

    

@router.get(app_constants.processor_models)
async def getProcessorModels(db: Session = Depends(get_db)):
        data = filtered_entities_service.getProcessorModelsService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.processor_models}"+"/{id}")
async def deleteProcessorModel(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteProcessorModelService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor model has been successfully deleted.')

    


@router.patch(f"{app_constants.processor_models}"+"/{id}")
async def updateProcessorModel(id: int, req: filtered_entities_schema.ProcessorModelsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateProcessorModelService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor model has been successfully updated.')

    
# ===================== End Processor Models =====================


# ===================== Generation Series =====================
@router.post(app_constants.generation_series)
async def createGenerationSeries(req: filtered_entities_schema.GenerationSeriesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createGenerationSeriesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The generation/series has been successfully created.")

    

@router.get(app_constants.generation_series)
async def getGenerationSeries(db: Session = Depends(get_db)):
        data = filtered_entities_service.getGenerationSeriesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.generation_series}"+"/{id}")
async def deleteGenerationSeries(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteGenerationSeriesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The generation/series has been successfully deleted.')

    


@router.patch(f"{app_constants.generation_series}"+"/{id}")
async def updateGenerationSeries(id: int, req: filtered_entities_schema.GenerationSeriesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateGenerationSeriesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The generation/series has been successfully updated.')

    
# ===================== End Generation Series =====================



# ===================== Display Types =====================
@router.post(app_constants.display_types)
async def createDisplayTypes(req: filtered_entities_schema.DisplayTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createDisplayTypesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The display type has been successfully created.")

    

@router.get(app_constants.display_types)
async def getDisplayTypes(db: Session = Depends(get_db)):
        data = filtered_entities_service.getDisplayTypesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.display_types}"+"/{id}")
async def deleteDisplayTypes(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteDisplayTypesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The display type has been successfully deleted.')

    


@router.patch(f"{app_constants.display_types}"+"/{id}")
async def updateDisplayTypes(id: int, req: filtered_entities_schema.DisplayTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateDisplayTypesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The display type has been successfully updated.')

    
# ===================== End Display Types =====================



# ===================== Special Features =====================
@router.post(app_constants.special_features)
async def createSpecialFeatures(req: filtered_entities_schema.SpecialFeaturesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createSpecialFeaturesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The special feature has been successfully created.")

    

@router.get(app_constants.special_features)
async def getSpecialFeatures(db: Session = Depends(get_db)):
        data = filtered_entities_service.getSpecialFeaturesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.special_features}"+"/{id}")
async def deleteSpecialFeatures(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteSpecialFeaturesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The special feature has been successfully deleted.')

    


@router.patch(f"{app_constants.special_features}"+"/{id}")
async def updateSpecialFeatures(id: int, req: filtered_entities_schema.SpecialFeaturesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateSpecialFeaturesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The special feature has been successfully updated.')

# ===================== End Special Features =====================




# ===================== Ram Sizes =====================
@router.post(app_constants.ram_sizes)
async def createRamSizes(req: filtered_entities_schema.RamSizesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createRamSizesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The ram size has been successfully created.")

    

@router.get(app_constants.ram_sizes)
async def getRamSizes(db: Session = Depends(get_db)):
        data = filtered_entities_service.getRamSizesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.ram_sizes}"+"/{id}")
async def deleteRamSizes(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteRamSizesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ram size has been successfully deleted.')

    


@router.patch(f"{app_constants.ram_sizes}"+"/{id}")
async def updateRamSizes(id: int, req: filtered_entities_schema.RamSizesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateRamSizesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ram size has been successfully updated.')

# ===================== End Ram Sizes =====================



# ===================== Ram Types =====================
@router.post(app_constants.ram_types)
async def createRamTypes(req: filtered_entities_schema.RamTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createRamTypesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The ram type has been successfully created.")

    

@router.get(app_constants.ram_types)
async def getRamTypes(db: Session = Depends(get_db)):
        data = filtered_entities_service.getRamTypesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.ram_types}"+"/{id}")
async def deleteRamTypes(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteRamTypesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ram type has been successfully deleted.')

    


@router.patch(f"{app_constants.ram_types}"+"/{id}")
async def updateRamTypes(id: int, req: filtered_entities_schema.RamTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateRamTypesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ram type has been successfully updated.')

# ===================== End Ram Types =====================



# ===================== HDD =====================
@router.post(app_constants.hdd)
async def createHDD(req: filtered_entities_schema.HDDRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createHDDService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The hdd has been successfully created.")

    

@router.get(app_constants.hdd)
async def getHDD(db: Session = Depends(get_db)):
        data = filtered_entities_service.getHDDService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.hdd}"+"/{id}")
async def deleteHDD(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteHDDService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The HDD has been successfully deleted.')

    


@router.patch(f"{app_constants.hdd}"+"/{id}")
async def updateHDD(id: int, req: filtered_entities_schema.HDDRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateHDDService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The HDD has been successfully updated.')

# ===================== End HDD =====================



# ===================== SSD =====================
@router.post(app_constants.ssd)
async def createSSD(req: filtered_entities_schema.SSDRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createSSDService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The ssd has been successfully created.")

    

@router.get(app_constants.ssd)
async def getSSD(db: Session = Depends(get_db)):
        data = filtered_entities_service.getSSDService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.ssd}"+"/{id}")
async def deleteSSD(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteSSDService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ssd has been successfully deleted.')

    


@router.patch(f"{app_constants.ssd}"+"/{id}")
async def updateSSD(id: int, req: filtered_entities_schema.SSDRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateSSDService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The ssd has been successfully updated.')

# ===================== End SSD =====================





# ===================== Graphics =====================
@router.post(app_constants.graphics)
async def createGraphics(req: filtered_entities_schema.GraphicsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createGraphicsService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The graphics has been successfully created.")

    

@router.get(app_constants.graphics)
async def getGraphics(db: Session = Depends(get_db)):
        data = filtered_entities_service.getGraphicsService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.graphics}"+"/{id}")
async def deleteGraphics(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteGraphicsService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The graphics has been successfully deleted.')

    


@router.patch(f"{app_constants.graphics}"+"/{id}")
async def updateGraphics(id: int, req: filtered_entities_schema.GraphicsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateGraphicsService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The graphics has been successfully updated.')

# ===================== End SSD =====================



# ===================== DisplaySizes =====================
@router.post(app_constants.display_sizes)
async def createDisplaySizes(req: filtered_entities_schema.DisplaySizesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.createDisplaySizesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The display sizes has been successfully created.")

    


@router.get(app_constants.display_sizes)
async def getDisplaySizes(db: Session = Depends(get_db)):
        data = filtered_entities_service.getDisplaySizesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    


@router.delete(f"{app_constants.display_sizes}"+"/{id}")
async def deleteGraphics(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.deleteDisplaySizesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The display sizes has been successfully deleted.')

    


@router.patch(f"{app_constants.display_sizes}"+"/{id}")
async def updateDisplaySizes(id: int, req: filtered_entities_schema.DisplaySizesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        filtered_entities_service.updateDisplaySizesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The display sizes has been successfully updated.')

# ===================== End Display Sizes =====================

