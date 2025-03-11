from fastapi import HTTPException, status
from app.models.social_link_model import SocialLink
from app.schemas.social_link_schema import SocialLinkRequest, SocialLinkResponse
from sqlalchemy.orm import Session




social_link_db = SocialLink


def createSocialLinkService(req: SocialLinkRequest, db: Session):
    
    # exist_data = db.query(display_sizes_db).filter(
    #     display_sizes_db.min_size == req.min_size, display_sizes_db.max_size == req.max_size
    # ).count()

    # if exist_data>0:
    #     raise HTTPException(status_code=status.HTTP_409_CONFLICT,
    #                         detail=f"Display sizes already exists.")

    new_data = social_link_db(**req.model_dump())
    db.add(new_data)
    db.commit()
    db.refresh(new_data)


def getSocialLinkService(db: Session):
    query = db.query(social_link_db)
    result = [
        SocialLinkResponse.model_validate(
            data).model_dump()
        for data in query.all()
    ]
    return result


def deleteSocialLinkService(id: int, db: Session):
    query = db.query(social_link_db).filter(id == social_link_db.id)
    if not query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'Not found with id {id}')
    query.delete(synchronize_session=False)
    db.commit()


def updateSocialLinkService(id: int, req: SocialLinkRequest, db: Session):
    # exist_data = db.query(display_sizes_db).filter(
    #     display_sizes_db.min_size == req.min_size,
    #     display_sizes_db.max_size == req.max_size
    # ).count()

    # if exist_data > 0:
    #     raise HTTPException(
    #         status_code=status.HTTP_409_CONFLICT,
    #         detail="Display sizes already exist."
    #     )

    query = db.query(social_link_db).filter(social_link_db.id == id).first()
    
    if not query:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Not found with id {id}"
        )

    query.platform = req.platform
    query.url = req.url

    db.commit()
    db.refresh(query)
