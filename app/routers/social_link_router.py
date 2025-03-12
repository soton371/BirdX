from fastapi import status, Depends, APIRouter
from app.core import app_constants, oauth2
from app.schemas.social_link_schema import SocialLinkRequest
from sqlalchemy.orm import Session
from app.core.app_response import ResponseSuccess
from app.core.database import get_db
from app.models import auth_model
from app.services import social_link_service



router = APIRouter(
    prefix="",
    tags=['Social Links']
)


@router.post(app_constants.social_link)
async def createSocialLink(req: SocialLinkRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        social_link_service.createSocialLinkService(req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="Successfully created.")


    


@router.get(app_constants.social_link)
async def getSocialLink(db: Session = Depends(get_db)):
        data = social_link_service.getSocialLinkService(db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)


    


@router.delete(f"{app_constants.social_link}"+"/{id}")
async def deleteSocialLink(id: int, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        social_link_service.deleteSocialLinkService(id=id, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'Successfully deleted.')
    


@router.patch(f"{app_constants.social_link}"+"/{id}")
async def updateSocialLink(id: int, req: SocialLinkRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        social_link_service.updateSocialLinkService(id=id, req=req, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message=f'Successfully updated.')



