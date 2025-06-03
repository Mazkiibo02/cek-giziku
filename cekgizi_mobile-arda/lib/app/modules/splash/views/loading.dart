import 'package:cekgizi_mobile/app/modules/splash/controllers/splash_controller.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends GetView<SplashController> {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(color: warnaPutih),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 130,
                  height: 165,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(color: warnaHitam, size: 40.0),
                  SizedBox(height: 20),
                  Text(
                    "Tunggu...",
                    style: hitamStyle.copyWith(fontSize: 14, fontWeight: light),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
