import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:cekgizi_mobile/app/widget/CustomNavbar.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  final controller = Get.put(HomeController()); // opsional

  void _onNavTap(int index) {
    setState(() {
      selectedIndex = index;

      // Opsional: Navigasi ke halaman lain jika ingin
      if (index == 2) {
        Get.toNamed(Routes.PROFIL);
      }
    });
  }

  Widget bagianProfil() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icon.png"),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Selamat datang",
                      style: hitamStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    ),
                    Text(
                      "Moh Fariz",
                      style: hitamStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/notif.png")),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,

      height: 141,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: warnaMerah,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pindai\nMakananmu\nCek Gizimu",
                  style: hitamStyle.copyWith(fontSize: 20, fontWeight: black),
                ),
                Text(
                  "Hidup sehat mulai sekarang",
                  style: hitamStyle.copyWith(fontSize: 12, fontWeight: light),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(top: 10),
            height: 141,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bagianFitur() {
    Widget CardFitur(String icon, VoidCallback fs) {
      return GestureDetector(
        onTap: fs,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: warnaPutih,
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(color: warnaHitam),

            boxShadow: [
              BoxShadow(color: warnaHitam, spreadRadius: 1, blurRadius: 1),
            ],
          ),
          child: Center(child: Image.asset(icon, width: 25, height: 25)),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CardFitur("assets/trad.png", () {}),
          CardFitur("assets/doc.png", () {
  print("Klik ke berita!");
  Get.toNamed(Routes.BERITA);
}),

          CardFitur("assets/hambur.png", () {}),
          CardFitur("assets/analys.png", () {}),
        ],
      ),
    );
  }

  Widget fiturUntuk() {
    return Container(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hanya Untukmu",
            style: hitamStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          SizedBox(height: 18),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,

                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: warnaHitam),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kamu Belum",
                            style: hitamStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Mengkonsumsi Sayuran\nhari ini, Makan sekarang!!!",
                            style: hitamStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 60),
                  ],
                ),
              ),

              Positioned(
                right: 30,
                top: -10,
                bottom: -10,
                child: Image.asset(
                  "assets/il1.png",
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget KontenUntuk() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 21),
              width: MediaQuery.of(context).size.width / 2,
              height: 274,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage("assets/il2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Pindai\nSekarang",
                  style: putihStyle.copyWith(
                    fontSize: 20,
                    fontWeight: extraBold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 274,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 21,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage("assets/il4.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Cek\nBerita",
                          style: putihStyle.copyWith(
                            fontSize: 20,
                            fontWeight: extraBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 21,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage("assets/il3.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Analisis",
                          style: putihStyle.copyWith(
                            fontSize: 20,
                            fontWeight: extraBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                bagianProfil(),
                header(),
                bagianFitur(),
                fiturUntuk(),
                KontenUntuk(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
