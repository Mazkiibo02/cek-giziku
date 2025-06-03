import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_e_controller.dart';

class ResetPasswordEView extends GetView<ResetPasswordEController> {
  const ResetPasswordEView({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController cs = TextEditingController();
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
              "Reset Password",
              style: hitamStyle.copyWith(fontSize: 22, fontWeight: bold),
            ),
            SizedBox(height: 18),
            Text(
              "Ubah Password kamu",
              style: hitamStyle.copyWith(fontSize: 22, fontWeight: light),
            ),
            SizedBox(height: 18),
            Input(
              w: double.infinity,
              h: 50,
              cekPassword: false,
              icon: "assets/lock.png",
              cs: cs,
              labelInput: "Kata Sandi",
            ),
            Input(
              w: double.infinity,
              h: 50,
              cekPassword: false,
              icon: "assets/lock.png",
              cs: cs,
              labelInput: "Konfirmasi Kata Sandi",
            ),

            SizedBox(height: 18),
            Button(
              w: double.infinity,
              h: 50,
              nama: "Selanjutnya",
              fungsi: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: warnaPutih,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [bagianAtas(), bagianMid()]),
      ),
    );
  }
}
