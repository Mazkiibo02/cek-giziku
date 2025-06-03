from flask import Blueprint
from controller.profileController import update_user

profile_bp = Blueprint("profile", __name__)
 
profile_bp.route("/update", methods=["PUT"])(update_user) 