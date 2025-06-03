import 'package:flutter/material.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';

class SplashPage1 extends StatelessWidget {
  const SplashPage1({super.key});

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
                        "Kenali Gizi\nharianmu mulai\ndari sekarang",
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
                      image: AssetImage('assets/biru.jpg'),
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
                    color: warnaBiru,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Isi setengah dari piringmu dengan sayur dan buah berwarna-warni untuk mencukupi kebutuhan serat, vitamin, dan antioksidan alami",
                          style: hitamStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Row(
                          children: [
                            _buildDot(true),
                            _buildDot(false),
                            _buildDot(false),
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
                    fungsi: () => Get.toNamed(Routes.SPLASH2),
                    nama: "Ayo",
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
        color: isActive ? warnaBirutua : warnaPutih,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
