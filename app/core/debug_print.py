from app.core.env_settings import settings

def debugPrint(obj):
    if settings.env_mood == "local":
        print(obj)
