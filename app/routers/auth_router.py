from fastapi import HTTPException, status, Depends, APIRouter, Response
from sqlalchemy.orm import Session
from app.core.app_response import ResponseFailed, ResponseSuccess
from app.core.database import get_db
from app.core.debug_print import debugPrint
from app.schemas import auth_schema
from app.core import app_constants
from app.services import auth_service


router = APIRouter(
    prefix="",
    tags=['Auths']
)


@router.post(app_constants.admin_login)
async def adminLogin(payload: auth_schema.AdminLoginRequest, response: Response, db: Session = Depends(get_db)):
    try:
        data = auth_service.adminLoginService(
            payload=payload, db=db, response=response)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data)

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"login error: {error}")
        return ResponseFailed()


@router.post(app_constants.send_otp)
async def sendOTP(payload: auth_schema.SendOTPRequest, db: Session = Depends(get_db)):
    try:
        auth_service.sendOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP sent successfully")

    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"sendPassword error: {error}")
        return ResponseFailed()


@router.post(app_constants.verify_otp)
async def verifyOTP(payload: auth_schema.VerifyOTPRequest, db: Session = Depends(get_db)):
    try:
        auth_service.verifyOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP verified successfully")
    except HTTPException as e:
        return ResponseFailed(status_code=e.status_code, message=e.detail)

    except Exception as error:
        debugPrint(f"sendPassword error: {error}")
        return ResponseFailed()
