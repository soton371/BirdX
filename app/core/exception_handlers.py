from fastapi import Request, status
from fastapi.exceptions import RequestValidationError
from app.core.response import ResponseFailed
from starlette.exceptions import HTTPException as StarletteHTTPException #for handle all exception
from sqlalchemy.exc import IntegrityError
from redis.exceptions import ConnectionError as RedisConnectionError

def add_exception_handlers(app):

        
    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(request: Request, exc: RequestValidationError):
        return ResponseFailed(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            message=exc.errors()[0]["msg"],
        )
        

    @app.exception_handler(StarletteHTTPException)
    async def http_exception_handler(request: Request, exc: StarletteHTTPException):
        return ResponseFailed(
            status_code=exc.status_code,
            message=exc.detail,
        )


    @app.exception_handler(IntegrityError)
    async def integrity_error_handler(request: Request, exc: IntegrityError):
        error_message = str(exc.orig)
        if "duplicate key value violates unique constraint" in error_message:
            platform = error_message.split("=")[1].strip()
            return ResponseFailed(
                status_code=status.HTTP_400_BAD_REQUEST,
                message=f"{platform}"
            )
        
        return ResponseFailed(
            status_code=status.HTTP_400_BAD_REQUEST,
            message="Database integrity error occurred."
        )


    @app.exception_handler(RedisConnectionError)
    async def redis_connection_error_handler(request: Request, exc: RedisConnectionError):
        return ResponseFailed(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            message="Redis connection error occurred. Please try again later."
        )

