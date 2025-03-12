from fastapi import HTTPException, status, Depends, APIRouter, Response
from sqlalchemy.orm import Session
from app.core.app_response import ResponseFailed, ResponseSuccess
from app.core.database import get_db
from app.core.debug_print import debugPrint
from app.schemas import auth_schema
from app.core import app_constants,oauth2
from app.services import auth_service
from app.models import auth_model


router = APIRouter(
    prefix="",
    tags=['Auths']
)


@router.post(app_constants.admin_login)
async def adminLogin(payload: auth_schema.AdminLoginRequest, response: Response, db: Session = Depends(get_db)):
        data = auth_service.adminLoginService(
            payload=payload, db=db, response=response)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data, message="Login successfully")



@router.post(app_constants.send_otp)
async def sendOTP(payload: auth_schema.SendOTPRequest, db: Session = Depends(get_db)):
        auth_service.sendOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP sent successfully")



@router.post(app_constants.verify_otp)
async def verifyOTP(payload: auth_schema.VerifyOTPRequest, db: Session = Depends(get_db)):
        data = auth_service.verifyOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP verified successfully", data=data)
    


@router.post(app_constants.reset_password)
async def resetPassword(payload: auth_schema.ResetPasswordRequest, db: Session = Depends(get_db), current_user: auth_model.Admin = Depends(oauth2.getCurrentUser)):
        auth_service.resetPasswordService(payload=payload, db=db,current_user=current_user)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="Password reset successfully")
   
    

