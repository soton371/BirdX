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
    try:
        filtered_entities_service.brandCreateService(brand_req=brand_req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The brand has been successfully created.")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"brandCreate error: {error}")
        return ResponseFailed()
    

@router.get(app_constants.brands)
async def getBrands(db: Session = Depends(get_db)):
    try:
        data = filtered_entities_service.getBrandsService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"getBrands error: {error}")
        return ResponseFailed()
    


@router.delete(f"{app_constants.brands}"+"/{brand_id}")
async def deleteBrand(brand_id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.deleteBrandService(brand_id=brand_id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The brand has been successfully deleted.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"deleteBrand error: {error}")
        return ResponseFailed()
    


@router.patch(f"{app_constants.brands}"+"/{brand_id}")
async def updateBrand(brand_id: int, brand_req: filtered_entities_schema.BrandsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.updateBrandService(brand_id=brand_id, brand_req=brand_req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The brand has been successfully updated.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"updateBrand error: {error}")
        return ResponseFailed()
    
# ===================== End Brand =====================






# ===================== Processor Type =====================
@router.post(app_constants.processor_types)
async def createProcessorTypes(req: filtered_entities_schema.ProcessorTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.createProcessorTypeService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The processor type has been successfully created.")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"createProcessorTypes error: {error}")
        return ResponseFailed()
    

@router.get(app_constants.processor_types)
async def getProcessorTypes(db: Session = Depends(get_db)):
    try:
        data = filtered_entities_service.getProcessorTypeService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"getProcessorTypes error: {error}")
        return ResponseFailed()
    


@router.delete(f"{app_constants.processor_types}"+"/{id}")
async def deleteProcessorTypes(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.deleteProcessorTypeService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor type has been successfully deleted.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"deleteProcessorTypes error: {error}")
        return ResponseFailed()
    


@router.patch(f"{app_constants.processor_types}"+"/{id}")
async def updateProcessorTypes(id: int, req: filtered_entities_schema.ProcessorTypesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.updateProcessorTypeService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor type has been successfully updated.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"updateProcessorTypes error: {error}")
        return ResponseFailed()
    
# ===================== End Processor Type =====================



# ===================== Processor Models =====================
@router.post(app_constants.processor_models)
async def createProcessorModels(req: filtered_entities_schema.ProcessorModelsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.createProcessorModelService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The processor model has been successfully created.")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"createProcessorModels error: {error}")
        return ResponseFailed()
    

@router.get(app_constants.processor_models)
async def getProcessorModels(db: Session = Depends(get_db)):
    try:
        data = filtered_entities_service.getProcessorModelsService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"getProcessorModels error: {error}")
        return ResponseFailed()
    


@router.delete(f"{app_constants.processor_models}"+"/{id}")
async def deleteProcessorModel(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.deleteProcessorModelService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor model has been successfully deleted.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"deleteProcessorModel error: {error}")
        return ResponseFailed()
    


@router.patch(f"{app_constants.processor_models}"+"/{id}")
async def updateProcessorModel(id: int, req: filtered_entities_schema.ProcessorModelsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.updateProcessorModelService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The processor model has been successfully updated.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"updateProcessorModel error: {error}")
        return ResponseFailed()
    
# ===================== End Processor Models =====================


# ===================== Generation Series =====================
@router.post(app_constants.generation_series)
async def createGenerationSeries(req: filtered_entities_schema.GenerationSeriesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.createGenerationSeriesService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The generation/series has been successfully created.")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"createGenerationSeries error: {error}")
        return ResponseFailed()
    

@router.get(app_constants.generation_series)
async def getGenerationSeries(db: Session = Depends(get_db)):
    try:
        data = filtered_entities_service.getGenerationSeriesService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"getGenerationSeries error: {error}")
        return ResponseFailed()
    


@router.delete(f"{app_constants.generation_series}"+"/{id}")
async def deleteGenerationSeries(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.deleteGenerationSeriesService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The generation/series has been successfully deleted.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"deleteGenerationSeries error: {error}")
        return ResponseFailed()
    


@router.patch(f"{app_constants.generation_series}"+"/{id}")
async def updateGenerationSeries(id: int, req: filtered_entities_schema.GenerationSeriesRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.updateGenerationSeriesService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'The generation/series has been successfully updated.')

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"updateGenerationSeries error: {error}")
        return ResponseFailed()
    
# ===================== End Generation Series =====================
