from alembic import op
import sqlalchemy as sa
from datetime import datetime

def upgrade():
    # Create new tables
    op.create_table(
        'user_preferences',
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('genre_id', sa.Integer(), nullable=False),
        sa.Column('weight', sa.Float(), nullable=False, default=1.0),
        sa.ForeignKeyConstraint(['user_id'], ['users.user_id'], ondelete='CASCADE'),
        sa.ForeignKeyConstraint(['genre_id'], ['genres.genre_id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('user_id', 'genre_id')
    )

    # Add new columns to existing tables
    op.add_column('manga', sa.Column('last_updated', sa.DateTime(), nullable=True))
    op.add_column('users', sa.Column('last_login', sa.DateTime(), nullable=True))

def downgrade():
    # Remove tables and columns in reverse order
    op.drop_table('user_preferences')
    op.drop_column('manga', 'last_updated')
    op.drop_column('users', 'last_login') 