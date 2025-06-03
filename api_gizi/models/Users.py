from extensi import db
from datetime import datetime
from sqlalchemy.sql import func
from models.NutrisiHarian import NutrisiHarian
import hashlib
import random


def acakid():
    random_number = str(random.randint(100,999))
    hash = hashlib.sha256(random_number.encode()).hexdigest()[:3]
    return hash

class Users(db.Model):
   
    
    id = db.Column(db.String(10), primary_key=True, default=lambda: acakid())  # ✅ JUGA BENAR
    nama = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False)
    gender = db.Column(db.Integer, nullable=True)  # 1: pria, 2: wanita
    umur = db.Column(db.Integer, nullable=True)
    kegiatan_level = db.Column(db.Integer, nullable=True)  # 1-5 bisa mewakili level aktivitas
    berat = db.Column(db.Float, nullable=True)
    tinggi = db.Column(db.Float, nullable=True)
    password = db.Column(db.String(255), nullable=False)
    nomer_telepon = db.Column(db.String(13), unique=True, nullable=False)
    alamat = db.Column(db.String(250))
    img_profil = db.Column(db.String(250), default="default.png")
    role = db.Column(db.String(4), default="user")
    is_verified = db.Column(db.Boolean, default=False)
    verification_code = db.Column(db.String(6), nullable=True)
    verification_expiry = db.Column(db.DateTime, nullable=True)
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=func.now())
    updated_at = db.Column(db.DateTime, default=func.now(), onupdate=func.now())

    # One-to-One relationship
    nutrisi_harian = db.relationship('NutrisiHarian', backref='user', uselist=False)

    def ubahKejson(self):
        return {
            "id": self.id,
            "nama": self.nama,
            "email": self.email,
            "gender": self.gender,
            "umur": self.umur,
            "kegiatan_level": self.kegiatan_level,
            "berat": self.berat,
            "tinggi": self.tinggi,
            "nomer_telepon": self.nomer_telepon,
            "alamat": self.alamat,
            "img_profil": self.img_profil,
            "role": self.role,
            "is_verified": self.is_verified,
            "is_active": self.is_active
        }