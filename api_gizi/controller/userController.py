from flask import request, jsonify
from extensi import db
from models.Users import Users

def detail_profile(user_id):
    """
    GET /user/<user_id>
    Mengambil data user berdasarkan ID.
    """
    user = Users.query.get(user_id)
    if not user:
        return jsonify({"error": "User tidak ditemukan"}), 404

    return jsonify(user.ubahKejson()), 200


def edit_profile(user_id):
    """
    PUT /user/<user_id>
    Mengubah data user berdasar JSON body. 
    Contoh body JSON:
    {
      "nama": "Nama Baru",
      "gender": 2,
      "umur": 25,
      "kegiatan_level": 3,
      "berat": 60.5,
      "tinggi": 165.0,
      "nomer_telepon": "081234567890",
      "alamat": "Jl. Contoh No.123",
      "img_profil": "foto_baru.png"
    }
    """
    user = Users.query.get(user_id)
    if not user:
        return jsonify({"error": "User tidak ditemukan"}), 404

    data = request.get_json() or {}
    allowed_fields = [
        "nama",
        "gender",
        "umur",
        "kegiatan_level",
        "berat",
        "tinggi",
        "nomer_telepon",
        "alamat",
        "img_profil"
    ]

    updated = False
    for field in allowed_fields:
        if field in data:
            setattr(user, field, data[field])
            updated = True

    if not updated:
        return jsonify({"message": "Tidak ada field valid untuk diubah"}), 400

    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        return jsonify({
            "error": "Gagal menyimpan perubahan",
            "detail": str(e)
        }), 500

    return jsonify(user.ubahKejson()), 200
