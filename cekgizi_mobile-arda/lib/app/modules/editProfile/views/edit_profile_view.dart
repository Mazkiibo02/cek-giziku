import 'package:flutter/material.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller untuk input
    final TextEditingController namaC = TextEditingController();
    final TextEditingController emailC = TextEditingController();
    final TextEditingController telpC = TextEditingController();
    final TextEditingController alamatC = TextEditingController();

    return Scaffold(
      backgroundColor: warnaPutih,
      body: Stack(
        children: [
          // Background profil
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgprofil.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),

          // Konten utama
          Column(
            children: [
              SizedBox(height: 100),
              // Foto profil
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/pp2.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Card edit profil berisi form input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Column(
                    children: [
                      Input(
                        w: double.infinity,
                        h: 40,
                        icon: "assets/nama.png",
                        cs: namaC,
                        cekPassword: false,
                        labelInput: "Nama",
                      ),
                      Input(
                        w: double.infinity,
                        cekPassword: false,
                        h: 40,
                        icon: "assets/email.png",
                        cs: emailC,
                        labelInput: "Email",
                      ),
                      Input(
                        w: double.infinity,
                        h: 40,
                        cekPassword: false,
                        icon: "assets/telp.png",
                        cs: telpC,
                        labelInput: "No Telp",
                      ),
                      Input(
                        w: double.infinity,
                        h: 40,
                        cekPassword: false,
                        icon: "assets/lokasiitem.png",
                        cs: alamatC,
                        labelInput: "Alamat",
                      ),
                      SizedBox(height: 20),
                      Button(
                        w: MediaQuery.of(context).size.width * 0.7,
                        h: 35,
                        nama: "Perbarui Profil",
                        fungsi: () {
                          // Belum ada aksi, hanya tampilan
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
