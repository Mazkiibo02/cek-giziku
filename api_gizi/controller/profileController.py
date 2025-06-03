from flask import jsonify, request
from extensi import db
from flask_jwt_extended import jwt_required, get_jwt_identity
from models.Users import Users

@jwt_required()
def update_user():
    data = request.get_json()
    user_id = get_jwt_identity()
    user = Users.query.get(user_id)

    if not user:
        return jsonify({"message": "User not found"}), 404

    if "nama" in data:
        user.nama = data["nama"]
    if "email" in data:
        user.email = data["email"]
    if "nomer_telepon" in data:
        user.nomer_telepon = data["nomer_telepon"]
    if "alamat" in data:
        user.alamat = data["alamat"]
    if "umur" in data:
        user.umur = data["umur"]
    if "tinggi" in data:
        user.tinggi = data["tinggi"]
    if "berat" in data:
        user.berat = data["berat"]
    if "kegiatan_level" in data:
        user.kegiatan_level = data["kegiatan_level"]
    if "gender" in data:
        user.gender = data["gender"]

    try:
        db.session.commit()
        return jsonify({"message": "Profil berhasil diperbarui"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to update profile", "error": str(e)}), 500 