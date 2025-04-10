from fastapi import FastAPI



app = FastAPI()


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

