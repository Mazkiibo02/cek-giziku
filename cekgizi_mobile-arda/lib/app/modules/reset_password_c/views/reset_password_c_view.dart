import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_c_controller.dart';

class ResetPasswordCView extends GetView<ResetPasswordCController> {
  const ResetPasswordCView({super.key});
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
              "Masukan kode verifikasi\nyang berada di email kamu",
              style: hitamStyle.copyWith(fontSize: 22, fontWeight: light),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                );
              }),
            ),

            SizedBox(height: 18),
            Button(
              w: double.infinity,
              h: 50,
              nama: "Selanjutnya",
              fungsi: () {
                Get.toNamed(Routes.RESET_PASSWORD_E);
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
