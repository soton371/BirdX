from redis import Redis

from app.core.debug_print import debugPrint

redis_client = Redis(host="localhost", port=6379, db=0, decode_responses=True)

def storeOTP(email: str, otp: str, ttl: int = 180):
    try:
        redis_client.setex(f"birdx_otp:{email}", ttl, otp)
        return True
    except Exception as error:
        debugPrint(f"storeOTP error: {error}")
        return False

def getOTP(email: str | None)-> (str | None):
    if email is None:
        return None
    return redis_client.get(f"birdx_otp:{email}")

def deleteOTP(email: str):
    redis_client.delete(f"birdx_otp:{email}")


