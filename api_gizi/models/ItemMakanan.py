from extensi import db
from datetime import datetime
from sqlalchemy.sql import func
import hashlib
import random

def acakid():
    random_number = str(random.randint(100,999))
    hash = hashlib.sha256(random_number.encode()).hexdigest()[:5]
    return hash


class ItemMakanan(db.Model):
    __tablename__ = 'item_makanan'

    id_item_makanan = db.Column(db.String(5), primary_key=True, default=lambda: acakid())
    nama = db.Column(db.String(255), nullable=False)
    kalori = db.Column(db.Float, nullable=False)
    tanggal = db.Column(db.Date, default=datetime.utcnow, nullable=False)
    protein = db.Column(db.Float, nullable=False)
    karbohidrat = db.Column(db.Float, nullable=False)
    serat = db.Column(db.Float, nullable=False)
    lemak = db.Column(db.Float)
    id_nutrisi_h = db.Column(db.String(5), db.ForeignKey('nutrisi_harian.id_nutrisi_h'), nullable=False)
    users_id = db.Column(db.String(5), db.ForeignKey('users.id'), nullable=False)
    created_at = db.Column(db.DateTime, default=func.now()) 
    updated_at = db.Column(db.DateTime, default=func.now(), onupdate=func.now())

    def ubahKejson(self):
        return {
            "id_item_makanan": self.id_item_makanan,
            "nama": self.nama,
            "kalori": self.kalori,
            "protein": self.protein,
            "karbohidrat": self.karbohidrat,
            "serat": self.serat,
            "lemak": self.lemak,
        }