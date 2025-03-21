from app.core.database import Base
from sqlalchemy import Column, String, Integer, Float


class Brands(Base):
    __tablename__ = "brands"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class ProcessorTypes(Base):
    __tablename__ = "processor_types"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class ProcessorModels(Base):
    __tablename__ = "processor_models"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class GenerationSeries(Base):
    __tablename__ = "generation_series"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class DisplayTypes(Base):
    __tablename__ = "display_types"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class SpecialFeatures(Base):
    __tablename__ = "special_features"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)

class RamSizes(Base):
    __tablename__ = "ram_sizes"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class RamTypes(Base):
    __tablename__ = "ram_types"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)


class HDD(Base):
    __tablename__ = "hdd"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)



class SSD(Base):
    __tablename__ = "ssd"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)



class Graphics(Base):
    __tablename__ = "graphics"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String, nullable=False, unique=True)



class DisplaySizes(Base):
    __tablename__ = "display_sizes"

    id = Column(Integer, primary_key=True, nullable=False)
    min_size = Column(Float, nullable=False, unique=True)
    max_size = Column(Float, nullable=False, unique=True)


