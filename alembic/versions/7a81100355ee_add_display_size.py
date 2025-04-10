"""add display size

Revision ID: 7a81100355ee
Revises: 9ed6027f4706
Create Date: 2025-03-08 14:43:18.863162

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '7a81100355ee'
down_revision: Union[str, None] = '9ed6027f4706'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('display_sizes',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('min_size', sa.Double(), nullable=False),
    sa.Column('max_size', sa.Double(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('max_size'),
    sa.UniqueConstraint('min_size')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('display_sizes')
    # ### end Alembic commands ###
