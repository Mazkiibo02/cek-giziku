import 'package:flutter/material.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';

class SplashPage3 extends StatelessWidget {
  const SplashPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul bagian atas
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    marginDefault,
                    24,
                    marginDefault,
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tips Hari ini",
                        style: hitamStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Hidup\nSehat dimulai\nHari ini.",
                        style: hitamStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Gambar vertikal
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginDefault),
                  height: 380,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      image: AssetImage('assets/kuning.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                // Kartu bawah dengan Stack
                Container(
                  margin: EdgeInsets.all(marginDefault),
                  height: 160, // pastikan cukup tinggi
                  decoration: BoxDecoration(
                    color: warnaOren,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Jangan lewatkan sarapan, karena itu adalah bahan bakar utama tubuhmu untuk memulai hari dengan energi dan fokus yang optimal.",
                          style: hitamStyle.copyWith(
                            fontSize: 13,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Row(
                          children: [
                            _buildDot(false),
                            _buildDot(false),
                            _buildDot(true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Tombol "Ayo" di pojok kanan bawah
            Positioned(
              bottom: 25,
              right: 24,
              child: Container(
                width: 118,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: warnaPutih, width: 3),
                  color: warnaPutih,
                ),
                child: Center(
                  child: Button(
                    w: 100,
                    h: 38,
                    fungsi: () => Get.toNamed(Routes.LOGIN),
                    nama: "Ayo",
                    // Navigasi ke halaman berikutnya
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Indikator halaman
  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isActive ? 40 : 40,
      decoration: BoxDecoration(
        color: isActive ? warnaOrentua : warnaPutih,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
