from fastapi import status, Depends, APIRouter, Response
from sqlalchemy.orm import Session
from app.core.security import getCurrentUser
from app.db.session import get_db
from app.features.auth import schemas
from app.core import route_names
from app.core.response import ResponseSuccess
from app.features.auth import services, models



router = APIRouter(
    prefix="",
    tags=['Auths']
)


@router.post(route_names.admin_login)
async def adminLogin(payload: schemas.AdminLoginRequest, response: Response, db: Session = Depends(get_db)):
        data = services.adminLoginService(
            payload=payload, db=db, response=response)
        return ResponseSuccess(status_code=status.HTTP_200_OK, data=data, message="Login successfully")




@router.post(route_names.send_otp)
async def sendOTP(payload: schemas.SendOTPRequest, db: Session = Depends(get_db)):
        services.sendOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP sent successfully")



@router.post(route_names.verify_otp)
async def verifyOTP(payload: schemas.VerifyOTPRequest, db: Session = Depends(get_db)):
        data = services.verifyOTPService(payload=payload, db=db)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="OTP verified successfully", data=data)
    


@router.post(route_names.reset_password)
async def resetPassword(payload: schemas.ResetPasswordRequest, db: Session = Depends(get_db), current_user: models.Admin = Depends(getCurrentUser)):
        services.resetPasswordService(payload=payload, db=db,current_user=current_user)
        return ResponseSuccess(status_code=status.HTTP_200_OK, message="Password reset successfully")
 
