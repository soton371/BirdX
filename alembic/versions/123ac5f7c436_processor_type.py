"""processor type

Revision ID: 123ac5f7c436
Revises: f4dcbb37ce4a
Create Date: 2025-02-21 21:28:05.409233

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '123ac5f7c436'
down_revision: Union[str, None] = 'f4dcbb37ce4a'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('processor_types',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.alter_column('brands', 'name',
               existing_type=sa.VARCHAR(),
               nullable=False)
    op.create_unique_constraint(None, 'brands', ['name'])
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'brands', type_='unique')
    op.alter_column('brands', 'name',
               existing_type=sa.VARCHAR(),
               nullable=True)
    op.drop_table('processor_types')
    # ### end Alembic commands ###
