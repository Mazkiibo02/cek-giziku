import 'dart:convert';

import 'package:cekgizi_mobile/app/data/Model/userModel.dart';
import 'package:cekgizi_mobile/app/data/Url/Urls.dart';
import 'package:cekgizi_mobile/app/modules/splash/views/loading.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // Import for Future.delayed

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool cekLoading = false.obs;
  Rx<Usermodel?> currentUser = Rx<Usermodel?>(null);
  Usermodel? get user => currentUser.value;

  @override
  void onInit() async {
    super.onInit();
    try {
      final box = GetStorage();
    if (box.hasData("user")) {
      var jsonUser = box.read("user");
      currentUser.value = Usermodel.fromJson(
        Map<String, dynamic>.from(jsonUser),
      );
      }
    } catch (e) {
      // Log the error or handle it appropriately
      print("Error in LoginController onInit: $e");
      // Depending on the desired behavior, you might want to clear corrupted data
      // final box = GetStorage();
      // box.remove("user");
      // box.remove("token");
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();

    super.onClose();
  }

  Future<void> login(String email, String password) async {
    try {
      cekLoading.value = true;
      Get.off(() => LoadingPage());

      final respon = await http.post(
        Uri.parse("${Urls().url}/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(respon.body);

      if (!data.containsKey("user") || !data.containsKey("token")) {
        Get.snackbar("Error", "Kamu belum tedaftar");
        return;
      }

      String? token = data["token"];
      var userData = data["user"];

      if (token == null || userData == null) {
        Get.snackbar("Error", "Token atau data user tidak valid!");
        return;
      }

      Usermodel user = Usermodel.fromJson(userData);

      if (!user.isVerified) {
        Get.toNamed(Routes.DETAIL_PROFILE, arguments: {"email": email});
        return;
      }

      final box = GetStorage();
      box.write("token", token);
      box.write("user", user.toJson());
      currentUser.value = user;

      Get.offAllNamed(Routes.HOME_PAGE);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      cekLoading.value = false;
    }
  }

  bool isLoggedIn() {
    final box = GetStorage();
    return box.hasData("token");
  }

  void logout() {
    final box = GetStorage();
    box.remove("token");
    box.remove("user");
    currentUser.value = null;
    Get.offAllNamed("/login");
  }
}
