import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget bagianAtas() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 329,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/au.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      );
    }

    Widget bagianMid() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: hitamStyle.copyWith(fontSize: 22, fontWeight: bold),
            ),
            SizedBox(height: 18),
            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/email.png",
              labelInput: "Email",
              h: 50,
              cs: controller.emailC,
            ),
            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/email.png",
              labelInput: "Password",
              h: 50,
              cs: controller.passC,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.RESET_PASSWORD_PB);
                },
                child: Text(
                  "Lupa Password?",
                  style: hitamStyle.copyWith(fontSize: 18, fontWeight: light),
                ),
              ),
            ),

            SizedBox(height: 18),
            Button(
              w: double.infinity,
              h: 50,
              nama: "Login",
              fungsi: () async {
                await controller.login(
                  controller.emailC.text,
                  controller.passC.text,
                );
              },
            ),
          ],
        ),
      );
    }

    Widget bagianBottom() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun?",
                  style: hitamStyle.copyWith(fontSize: 16),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER_PAGE);
                  },
                  child: Text(
                    "Buat Akun",
                    style: biruStyle.copyWith(fontSize: 16, fontWeight: bold),
                  ),
                ),
              ],
            ),

            Text("Atau", style: hitamStyle.copyWith(fontSize: 16)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/fb.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/gogel.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: warnaPutih,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [bagianAtas(), bagianMid(), bagianBottom()]),
      ),
    );
  }
}
