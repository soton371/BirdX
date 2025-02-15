from app.core.config import settings

def debugPrint(obj):
    if settings.env_mood == "local":
        print(obj)

