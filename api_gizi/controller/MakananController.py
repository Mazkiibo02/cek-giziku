from flask_jwt_extended import create_access_token, get_jwt_identity, jwt_required
from flask import request, jsonify
from datetime import date
from models.NutrisiHarian import NutrisiHarian
from models.ItemMakanan import ItemMakanan
from extensi import db


@jwt_required()
def tambah_makanan_scan():
    users_id = get_jwt_identity()
    data = request.get_json()
    hasil = data.get("hasil")  # list of dict makanan

    
    nutrisi = NutrisiHarian.query.filter_by(users_id=users_id).first()
    if not nutrisi:
        return jsonify({"message": "Isi data diri dulu untuk dapat target nutrisi harian"}), 400

    for item in hasil:
        makanan = ItemMakanan(
            nama=item['nama'],
            kalori=item['kalori'],
            protein=item['protein'],
            karbohidrat=item['karbohidrat'],
            serat=item['serat'],
            lemak=item.get('lemak', 0),
            users_id=users_id,
            id_nutrisi_h=nutrisi.id_nutrisi_h,
            tanggal=date.today()
        )
        db.session.add(makanan)

    db.session.commit()
    return jsonify({"message": "Makanan hasil scan berhasil ditambahkan"})


@jwt_required()
def progres_gizi():
    users_id = get_jwt_identity()
    today = date.today()

    # Ambil target nutrisi terakhir user (bukan hanya hari ini)
    nutrisi = NutrisiHarian.query.filter_by(users_id=users_id).first()


    if not nutrisi:
        return jsonify({"message": "Isi data diri dulu untuk dapat target nutrisi harian"}), 400

    # Ambil konsumsi makanan yang dimasukkan hari ini
    konsumsi = {
        'kalori': 0,
        'protein': 0,
        'karbohidrat': 0,
        'serat': 0,
        'lemak': 0
    }

    konsumsi_items = ItemMakanan.query.filter_by(users_id=users_id, tanggal=today).all()

    for item in konsumsi_items:
        konsumsi['kalori'] += item.kalori
        konsumsi['protein'] += item.protein
        konsumsi['karbohidrat'] += item.karbohidrat
        konsumsi['serat'] += item.serat
        konsumsi['lemak'] += item.lemak or 0

    persen = {
        'kalori': round(konsumsi['kalori'] / nutrisi.kalori * 100, 1),
        'protein': round(konsumsi['protein'] / nutrisi.protein * 100, 1),
        'karbohidrat': round(konsumsi['karbohidrat'] / nutrisi.karbohidrat * 100, 1),
        'serat': round(konsumsi['serat'] / nutrisi.serat * 100, 1),
        'lemak': round(konsumsi['lemak'] / nutrisi.lemak * 100, 1) if nutrisi.lemak else 0
    }

    return jsonify({
        "target": {
            "kalori": nutrisi.kalori,
            "protein": nutrisi.protein,
            "karbohidrat": nutrisi.karbohidrat,
            "serat": nutrisi.serat,
            "lemak": nutrisi.lemak
        },
        "konsumsi": konsumsi,
        "persen_terpenuhi": persen
    })