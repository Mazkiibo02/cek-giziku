import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
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
              "Register",
              style: hitamStyle.copyWith(fontSize: 22, fontWeight: bold),
            ),
            SizedBox(height: 18),
            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/user.png",
              labelInput: "Nama",
              h: 50,
              cs: controller.nameController,
            ),
            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/email.png",
              labelInput: "Email",
              h: 50,
              cs: controller.emailController,
            ),

            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/call.png",
              labelInput: "Nomer Telepon",
              h: 50,
              cs: controller.nomerTeleponC,
            ),
            Input(
              cekPassword: true,
              w: double.infinity,
              icon: "assets/lock.png",
              labelInput: "Kata Sandi",
              h: 50,
              cs: controller.passwordController,
            ),

            SizedBox(height: 18),
            Button(
              w: double.infinity,
              h: 50,
              nama: "Register",
              fungsi: () async {
                await controller.buatAkun(
                  controller.emailController.text,
                  controller.passwordController.text,
                  controller.nomerTeleponC.text,
                  controller.nameController.text,
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
                  "Sudah punya akun?",
                  style: hitamStyle.copyWith(fontSize: 16),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text(
                    "Masuk",
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
