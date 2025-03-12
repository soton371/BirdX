from fastapi import FastAPI, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.exceptions import RequestValidationError
from app.core.app_response import ResponseFailed
from app.core.debug_print import debugPrint
from app.routers import auth_router, filtered_entities_router, social_link_router
from starlette.exceptions import HTTPException as StarletteHTTPException #for handle all exception
from sqlalchemy.exc import IntegrityError
from redis.exceptions import ConnectionError as RedisConnectionError



app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    # allow_origins=["http://localhost:8000", "https://yourfrontend.com"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

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
    debugPrint(f'exc error: {exc}')
    return ResponseFailed(
        status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
        message="Redis connection error occurred. Please try again later."
    )


app.include_router(auth_router.router)
app.include_router(filtered_entities_router.router)
app.include_router(social_link_router.router)



@app.get("/")
async def root():
    return {"message": "Hello World"}


#source .venv/bin/activate
#uvicorn app.main:app --host 192.168.0.104 --port 8000 --reload
#fastapi dev app/main.py
# variable: variable_name
# function & method: functionName
# class: ClassName
# http://127.0.0.1:8000
# redis install in own machine | brew install redis | then | pip install redis | then check | redis-server | or | redis-cli
# found hole conflict http status
# alembic revision --autogenerate -m 'auto-vote' || alembic upgrade head

