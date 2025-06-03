import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_profile_controller.dart';
import 'package:cekgizi_mobile/tema.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  const DetailProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      body: Stack(
        children: [
          // Background profil dengan gambar
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300, // Bisa kamu atur ukurannya
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgprofil.png'),
                fit: BoxFit.cover, // Bisa kamu ubah ke BoxFit.fill, etc
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100), // Jarak atas
                // Card Profil
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
                // Card Detail Profile
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
                    child: Obx(() {
                      print("Obx rebuilding..."); // Debug print
                      print(
                        "isLoading: ${controller.isLoading.value}",
                      ); // Debug print
                      print(
                        "User data in Obx: ${controller.user.value}",
                      ); // Debug print

                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (controller.user.value != null) {
                        final user = controller.user.value!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildProfileItem(Icons.person, "Nama", user.nama),
                            SizedBox(height: 16),
                            buildProfileItem(Icons.email, "Email", user.email),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.phone,
                              "No Telp",
                              user.nomer_telepon,
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.location_on,
                              "Alamat",
                              user.alamat,
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.calendar_today,
                              "Umur",
                              user.umur != null ? "${user.umur} tahun" : "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.height,
                              "Tinggi Badan",
                              user.tinggi != null ? "${user.tinggi} cm" : "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.scale,
                              "Berat Badan",
                              user.berat != null ? "${user.berat} kg" : "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.fitness_center,
                              "Level Kegiatan",
                              user.kegiatan_level != null
                                  ? "Level ${user.kegiatan_level}"
                                  : "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.male,
                              "Gender",
                              user.gender != null
                                  ? (user.gender == 1 ? "Pria" : "Wanita")
                                  : "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.assignment_ind,
                              "Role",
                              user.role ?? "N/A",
                            ),
                            SizedBox(height: 16),
                            buildProfileItem(
                              Icons.check_circle,
                              "Is Active",
                              user.is_active != null
                                  ? (user.is_active! ? "Yes" : "No")
                                  : "N/A",
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("Failed to load profile data."),
                        );
                      }
                    }),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: hitamStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                content,
                style: hitamStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
