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


@router.post(app_constants.brands)
async def brandCreate(brand_req: filtered_entities_schema.BrandsRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
    try:
        filtered_entities_service.brandCreateService(brand_req=brand_req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="The brand has been successfully created.")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"adminLogin error: {error}")
        return ResponseFailed()
    

