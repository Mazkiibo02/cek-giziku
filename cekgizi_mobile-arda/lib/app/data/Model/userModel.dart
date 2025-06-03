class Usermodel {
  String id;
  String nama;
  String email;
  String nomer_telepon;
  String alamat;
  double poin;
  String img_profil;
  bool isVerified;
  int? umur;
  double? tinggi;
  double? berat;
  int? kegiatan_level;
  int? gender;
  String? role;
  bool? is_active;

  Usermodel({
    required this.id,
    required this.nama,
    required this.email,
    required this.nomer_telepon,
    required this.alamat,
    required this.poin,
    required this.img_profil,
    required this.isVerified,
    this.umur,
    this.tinggi,
    this.berat,
    this.kegiatan_level,
    this.gender,
    this.role,
    this.is_active,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'] ?? "",
      nama: json['nama'] ?? "",
      email: json['email'] ?? "",
      nomer_telepon: json['nomer_telepon'] ?? "",
      alamat: json['alamat'] ?? "",
      poin: (json['poin'] as num?)?.toDouble() ?? 0.0,
      img_profil: json['img_profil'] ?? "default.png",
      isVerified: json['is_verified'] ?? false,
      umur: json['umur'] as int?,
      tinggi: (json['tinggi'] as num?)?.toDouble(),
      berat: (json['berat'] as num?)?.toDouble(),
      kegiatan_level: json['kegiatan_level'] as int?,
      gender: json['gender'] as int?,
      role: json['role'] as String?,
      is_active: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "email": email,
      "nomer_telepon": nomer_telepon,
      "alamat": alamat,
      "poin": poin,
      "img_profil": img_profil,
      "is_verified": isVerified,
      "umur": umur,
      "tinggi": tinggi,
      "berat": berat,
      "kegiatan_level": kegiatan_level,
      "gender": gender,
      "role": role,
      "is_active": is_active,
    };
  }
}
