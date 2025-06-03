import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Stack(
            children: [
              // Konten utama di kiri atas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 160), // <--- Tambahkan jarak dari atas
                  // Logo
                  Container(
                    width: 130,
                    height: 165,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Judul
                  Text(
                    "Scan Realtime\nVisual Food Diary\nFood Stats",
                    style: hitamStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Link login
                  Row(
                    children: [
                      Text(
                        "Sudah punya akun?",
                        style: hitamStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text(
                          "Masuk.",
                          style: hitamStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            color: warnaBiru,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Tombol di kanan bawah
              Positioned(
                right: 0,
                bottom: 0,
                child: Button(
                  w: 120,
                  h: 50,
                  nama: "Ayo",
                  fungsi: () {
                    Get.toNamed(Routes.SPLASH1); // atau rute berikutnya
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
