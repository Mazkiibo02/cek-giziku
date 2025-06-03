import 'package:cekgizi_mobile/app/controllers/notif_controller_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'app/routes/app_pages.dart';
import 'firebase_background_handler.dart';
import 'app/modules/login/controllers/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Get.put(LoginController());

  final notifController = NotifControllerController();
  await notifController.setupNotification();
  String cekPengguna() {
    final box = GetStorage();
    final token = box.read("token");
    print("Isi semua dari GetStorage:");
    print(box.getKeys()); // Melihat semua key yang disimpan
    print("Token: ${box.read('token')}"); // M
    if (token != null && token is String && !JwtDecoder.isExpired(token)) {
      return Routes.MAINPAGES;
    } else {
      return Routes.SPLASH;
    }
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      locale: Locale('id', 'ID'),
      initialRoute: cekPengguna(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    ),
  );
}
