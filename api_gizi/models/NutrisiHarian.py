from extensi import db
from datetime import datetime
from sqlalchemy.sql import func
from models.ItemMakanan import ItemMakanan
import hashlib
import random

def acakid():
    random_number = str(random.randint(100,999))
    hash = hashlib.sha256(random_number.encode()).hexdigest()[:5]
    return hash

class NutrisiHarian(db.Model):
    __tablename__ = 'nutrisi_harian'

    id_nutrisi_h = db.Column(db.String(5), primary_key=True, default=lambda: acakid())
    tanggal = db.Column(db.Date, default=datetime.utcnow, nullable=False)
    kalori = db.Column(db.Float, nullable=False)
    protein = db.Column(db.Float, nullable=False)
    karbohidrat = db.Column(db.Float, nullable=False)
    serat = db.Column(db.Float, nullable=False)
    lemak = db.Column(db.Float)
    users_id = db.Column(db.String(10), db.ForeignKey('users.id'), unique=True, nullable=False)
    created_at = db.Column(db.DateTime, default=func.now())
    updated_at = db.Column(db.DateTime, default=func.now(), onupdate=func.now())

    # One-to-Many relationship
    item_makanan = db.relationship('ItemMakanan', backref='nutrisi_harian', lazy=True)