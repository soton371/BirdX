from fastapi import status, Depends, APIRouter, Response
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.features.auth import schemas
from app.core import route_names
from app.core.response import ResponseSuccess
from app.features.auth import services



router = APIRouter(
    prefix="",
    tags=['Auths']
)


@router.post(route_names.admin_login)
async def adminLogin(payload: schemas.AdminLoginRequest, response: Response, db: Session = Depends(get_db)):
        data = services.adminLoginService(
            payload=payload, db=db, response=response)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data, message="Login successfully")

