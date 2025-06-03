from flask import Blueprint
from controller.MakananController import tambah_makanan_scan, progres_gizi

Makanan_bp = Blueprint("makanan", __name__)

Makanan_bp.route("/tambah", methods=["POST"])(tambah_makanan_scan)
Makanan_bp.route("/ambilGizi", methods=["GET"])(progres_gizi)

