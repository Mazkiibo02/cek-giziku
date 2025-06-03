import 'dart:convert';

import 'package:cekgizi_mobile/app/data/Url/Urls.dart';
import 'package:cekgizi_mobile/app/modules/splash/views/loading.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterPageController extends GetxController {
  RxBool cekLoading = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomerTeleponC = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    nomerTeleponC.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> buatAkun(
    String email,
    String password,
    String nomer,
    String nama,
  ) async {
    try {
      cekLoading.value = true;

      Get.off(() => LoadingPage());
      final response = await http.post(
        Uri.parse("${Urls().url}/auth/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "nama": nama,
          "password": password,
          "nomer_telepon": nomer,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(Routes.VERIFIKASI_EMAIL, arguments: {"email": email});
      } else {
        Get.snackbar("Error", "Register gagal: ${data['message']}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      cekLoading.value = false;
    }
  }
}
