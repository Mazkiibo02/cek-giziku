from flask import Blueprint
from controller.authController import register, login, verifikasiEmail, ubahPassword,MintaRequestReset, kodeReset, complete_profile,google_login, google_callback, facebook_login, facebook_callback, get_user_profile


auth_bp = Blueprint("auth", __name__)

auth_bp.route("/register", methods=["POST"])(register)
auth_bp.route("/verify-email", methods=["POST"])(verifikasiEmail)
auth_bp.route("/login", methods=["POST"])(login)
auth_bp.route("/datadiri", methods=["POST"])(complete_profile)
auth_bp.route("/mintaKode", methods=["POST"])(MintaRequestReset)
auth_bp.route("/kodeVerifikasi", methods=["POST"])(kodeReset)
auth_bp.route("/resetpassword", methods=["POST"])(ubahPassword)
auth_bp.route("/profile", methods=["GET"])(get_user_profile)
# Google OAuth
auth_bp.route("/google/login", methods=["GET"])(google_login)
auth_bp.route("/google/callback", methods=["GET"])(google_callback)

# Facebook OAuth
auth_bp.route("/facebook/login", methods=["GET"])(facebook_login)
auth_bp.route("/facebook/callback", methods=["GET"])(facebook_callback)
