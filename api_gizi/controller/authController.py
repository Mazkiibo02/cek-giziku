from flask import jsonify, request
from extensi import bcrypt, db, mail
from datetime import datetime,timedelta  
from flask_bcrypt import generate_password_hash
from models.NutrisiHarian import NutrisiHarian
from flask_mail import Message
from flask_jwt_extended import create_access_token, get_jwt_identity, jwt_required
from models.Users import Users
from werkzeug.utils import secure_filename
from flask import current_app
import random
import requests
import os
import hashlib
import uuid
UPLOAD_FOLDER = 'static/profil'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def register():
    data = request.get_json()
    hashed_password = bcrypt.generate_password_hash(data["password"]).decode("utf-8")
    verification_code = str(random.randint(100000, 999999))
    expiration_time = datetime.utcnow() + timedelta(seconds=600)  # Kode valid 30 detik

    new_user = Users(
        nama=data["nama"],
        email=data["email"],
        password=hashed_password,
        nomer_telepon=data["nomer_telepon"],

        alamat=data.get("alamat", ""),
        verification_code=verification_code,
        verification_expiry=expiration_time,
        is_active=True,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow()
    )
    existing = Users.query.filter_by(email=data['email']).first()
    if existing:
        return jsonify({"message": "Email sudah terdaftar"}), 400
    db.session.add(new_user)
    db.session.commit()

    msg = Message("Kode Verifikasi", sender="emailkamu@gmail.com", recipients=[data["email"]])
    msg.body = f"Kode verifikasi Anda: {verification_code}. Berlaku selama 30 detik."
    mail.send(msg)

    return jsonify({
        "message": "Selamat udah buat akun,silah cek email untuk verifikasi",
        "user": new_user.ubahKejson()
    }), 201




def login():
    data = request.get_json()
    user = Users.query.filter_by(email=data['email']).first()

    if user and bcrypt.check_password_hash(user.password, data['password']):
        if not user.is_verified:
            return jsonify({"message": "Akun belum diverifikasi!, silahkan verifikasi dahulu ya"}), 403
        
        token = create_access_token(identity=user.id, expires_delta=timedelta(weeks=1))  # Token berlaku 7 hari
        return jsonify({"token": token, "user": user.ubahKejson()}), 200
    
    return jsonify({"message": "Email atau password salah!"}), 401


def verifikasiEmail():
    data = request.get_json()
    user = Users.query.filter_by(email=data["email"], verification_code=data["code"]).first()

    if user:
        if datetime.utcnow() > user.verification_expiry:
            return jsonify({"message": "Kode verifikasi kadaluarsa!"}), 400

        user.is_verified = True
        user.verification_code = None
        user.verification_expiry = None
        user.updated_at = datetime.utcnow()
        db.session.commit()
        return jsonify({"message": "Akun berhasil diverifikasi"}), 200
    
    return jsonify({"message": "Kode verifikasi salah!"}), 400


def MintaRequestReset():
    data = request.get_json()
    user = Users.query.filter_by(email=data["email"]).first()

    if user:
        reset_code = str(random.randint(1000, 9999))
        user.verification_code = reset_code
        user.verification_expiry = datetime.utcnow() + timedelta(minutes=5)  # Kode valid 5 menit
        db.session.commit()

        msg = Message("Reset Password Code", sender="emailkamu@gmail.com", recipients=[data["email"]])
        msg.body = f"Kode reset password Anda: {reset_code}. Berlaku selama 5 menit."
        mail.send(msg)

        return jsonify({"message": "Kode reset password dikirim ke email"}), 200
    
    return jsonify({"message": "Email tidak ditemukan!"}), 404

def kodeReset():
    data = request.get_json()
    user = Users.query.filter_by(email=data["email"], verification_code=data["code"]).first()

    if user:
        if datetime.utcnow() > user.verification_expiry:
            return jsonify({"message": "Kode reset kadaluarsa!"}), 400
        return jsonify({"message": "Kode benar, silakan reset password"}), 200
    
    return jsonify({"message": "Kode salah!"}), 400

def ubahPassword():
    data = request.get_json()
    user = Users.query.filter_by(email=data["email"], verification_code=data["code"]).first()

    if user:
        if datetime.utcnow() > user.verification_expiry:
            return jsonify({"message": "Kode reset kadaluarsa!"}), 400

        hashed_password = bcrypt.generate_password_hash(data["new_password"]).decode("utf-8")
        user.password = hashed_password
        user.verification_code = None
        user.verification_expiry = None
        user.updated_at = datetime.utcnow()
        db.session.commit()

        return jsonify({"message": "Password berhasil direset, silakan login"}), 200
    
    return jsonify({"message": "Kode salah!"}), 400


def hitung_kebutuhan_nutrisi(user):
    if user.gender == 1:  # pria
        bmr = 10 * user.berat + 6.25 * user.tinggi - 5 * user.umur + 5
    else:  # wanita
        bmr = 10 * user.berat + 6.25 * user.tinggi - 5 * user.umur - 161
    
    activity_factor = [1.2, 1.375, 1.55, 1.725, 1.9][user.kegiatan_level - 1]
    kalori = bmr * activity_factor

    return {
        "kalori": kalori,
        "protein": kalori * 0.15 / 4,
        "karbohidrat": kalori * 0.55 / 4,
        "lemak": kalori * 0.25 / 9,
        "serat": 25  # atau bisa kamu hitung dari berat
    }


@jwt_required()
def complete_profile():
    user_id = get_jwt_identity()
    user = Users.query.get(user_id)

    data = request.get_json()
    user.gender = data["gender"]
    user.umur = data["umur"]
    user.berat = data["berat"]
    user.tinggi = data["tinggi"]
    user.kegiatan_level = data["kegiatan_level"]

    db.session.commit()

    hasil = hitung_kebutuhan_nutrisi(user)

    nutrisi = NutrisiHarian(
        tanggal=datetime.utcnow().date(),
        kalori=hasil["kalori"],
        protein=hasil["protein"],
        karbohidrat=hasil["karbohidrat"],
        serat=hasil["serat"],
        lemak=hasil["lemak"],
        users_id=user.id
    )
    db.session.add(nutrisi)
    db.session.commit()
    return jsonify({"message": "Profil berhasil dilengkapi"})

@jwt_required()
def update_user():
    data = request.get_json()
    user_id = get_jwt_identity()  # Ambil user ID dari token JWT
    user = Users.query.get(user_id)

    if not user:
        return jsonify({"message": "User not found"}), 404

    # Update fields if they exist in the request data
    if "nama" in data:
        user.nama = data["nama"]
    if "email" in data:
        # You might want to add email verification if email is changed
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

    # Handle profile image file upload if it exists
    # Note: File uploads with JSON body require special handling
    # For simplicity, I'm assuming image upload is handled separately or not via this JSON endpoint.
    # If you need to handle file uploads with this endpoint, you'll need to adjust request.get_json() and file handling.
    # if 'img_profil' in request.files:
    #     file = request.files['img_profil']
    #     if file and allowed_file(file.filename):
    #         filename = secure_filename(file.filename)
    #         filepath = os.path.join(UPLOAD_FOLDER, filename)
    #         file.save(filepath)
    #         user.img_profil = filename

    try:
        db.session.commit()
        return jsonify({"message": "Profil berhasil diperbarui"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to update profile", "error": str(e)}), 500

@jwt_required()
def get_user_profile():
    user_id = get_jwt_identity()
    user = Users.query.get(user_id)

    if user:
        return jsonify({"user": user.ubahKejson()}), 200
    else:
        return jsonify({"message": "User not found"}), 404

# =============== GOOGLE OAUTH ===============
from flask import jsonify, current_app

def google_login():
    params = {
        "client_id": current_app.config['GOOGLE_CLIENT_ID'],
        "redirect_uri": current_app.config['GOOGLE_REDIRECT_URI'],
        "response_type": "code",
        "scope": "openid email profile",
        "access_type": "offline",
        "prompt": "select_account"
    }
    url = "https://accounts.google.com/o/oauth2/v2/auth"
    redirect_url = f"{url}?{'&'.join([f'{k}={v}' for k, v in params.items()])}"
    return jsonify({"auth_url": redirect_url})

def google_callback():
    code = request.args.get("code")
    if not code:
        return jsonify({"error": "No code provided"}), 400

    # 1. Tukar code dengan token
    token_data = {
        "code": code,
        "client_id": current_app.config["GOOGLE_CLIENT_ID"],
        "client_secret": current_app.config["GOOGLE_CLIENT_SECRET"],
        "redirect_uri": current_app.config["GOOGLE_REDIRECT_URI"],
        "grant_type": "authorization_code"
    }

    token_resp = requests.post("https://oauth2.googleapis.com/token", data=token_data)
    if token_resp.status_code != 200:
        return jsonify({"error": "Gagal mendapatkan token Google", "detail": token_resp.text}), 400

    access_token = token_resp.json().get("access_token")
    if not access_token:
        return jsonify({"error": "Gagal mendapatkan access_token"}), 400

    # 2. Ambil info user dari Google
    userinfo_resp = requests.get(
        "https://www.googleapis.com/oauth2/v2/userinfo",
        headers={"Authorization": f"Bearer {access_token}"}
    )
    if userinfo_resp.status_code != 200:
        return jsonify({"error": "Gagal mendapatkan userinfo dari Google"}), 400

    userinfo = userinfo_resp.json()
    email = userinfo.get("email")
    nama = userinfo.get("name", "")
    foto = userinfo.get("picture", "")

    if not email:
        return jsonify({"error": "Email tidak ditemukan dari Google"}), 400

    # 3. Cari user, jika belum ada → buat baru
    user = Users.query.filter_by(email=email).first()
    if not user:
        # Buat nomor telepon dummy dari hash email agar unik
        dummy_phone = "08" + hashlib.sha1(email.encode()).hexdigest()[:10]

        user = Users(
            nama=nama,
            email=email,
            password="oauth-google",  # placeholder
            nomer_telepon=dummy_phone,
            alamat="",
            img_profil=foto,
            is_verified=True,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.session.add(user)
        db.session.commit()
    else:
        # Update profil jika user sudah ada
        user.nama = nama
        user.img_profil = foto
        user.is_verified = True
        user.updated_at = datetime.utcnow()
        db.session.commit()

    # 4. Generate token login
    token = create_access_token(identity=user.id, expires_delta=timedelta(weeks=1))
    return jsonify({
        "token": token,
        "user": user.ubahKejson()
    }), 200


# =============== FACEBOOK OAUTH ===============
def facebook_login():
    print("FACEBOOK_CLIENT_ID:", current_app.config['FACEBOOK_CLIENT_ID']) 
    params = {
        "client_id": current_app.config['FACEBOOK_CLIENT_ID'],
        "redirect_uri": current_app.config['FACEBOOK_REDIRECT_URI'],
        "scope": "email,public_profile",
        "response_type": "code"
    }
    url = "https://www.facebook.com/v14.0/dialog/oauth"
    redirect_url = f"{url}?{'&'.join([f'{k}={v}' for k, v in params.items()])}"
    return jsonify({"auth_url": redirect_url})

def facebook_callback():
    code = request.args.get("code")
    if not code:
        return jsonify({"error": "No code provided"}), 400

    token_params = {
        "client_id": current_app.config["FACEBOOK_CLIENT_ID"],
        "redirect_uri": current_app.config["FACEBOOK_REDIRECT_URI"],
        "client_secret": current_app.config["FACEBOOK_CLIENT_SECRET"],
        "code": code
    }
    token_resp = requests.get("https://graph.facebook.com/v14.0/oauth/access_token", params=token_params)
    token_json = token_resp.json()
    if "error" in token_json:
        return jsonify({"error": token_json["error"]["message"]}), 400
    access_token = token_json.get("access_token")

    if not access_token:
        return jsonify({"error": "Gagal mendapatkan token akses dari Facebook"}), 400

    userinfo_params = {
        "fields": "id,name,email,picture",
        "access_token": access_token
    }

    userinfo_resp = requests.get("https://graph.facebook.com/me", params=userinfo_params)
    userinfo = userinfo_resp.json()
    if "error" in userinfo:
        return jsonify({"error": userinfo["error"]["message"]}), 400

    email = userinfo.get("email")
    nama = userinfo.get("name") or (email.split("@")[0] if email else "FacebookUser")
    foto = userinfo.get("picture", {}).get("data", {}).get("url", "")

    if not email:
        return jsonify({"error": "Email tidak tersedia dari Facebook. Pastikan izin email disetujui."}), 400

    user = Users.query.filter_by(email=email).first()
    if not user:
        user = Users(
            nama=nama,
            email=email,
            password="oauth-facebook",
            img_profil=foto,
            is_verified=True,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow(),
            nomer_telepon="fb_" + uuid.uuid4().hex[:8],  # Supaya unique
            alamat=""
        )
        db.session.add(user)
        db.session.commit()
    else:
        user.nama = nama
        user.img_profil = foto
        user.is_verified = True
        user.updated_at = datetime.utcnow()
        db.session.commit()

    token = create_access_token(identity=user.id, expires_delta=timedelta(weeks=1))
    return jsonify({"token": token, "user": user.ubahKejson()}), 200