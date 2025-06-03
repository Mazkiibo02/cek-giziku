import 'package:cekgizi_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:cekgizi_mobile/tema.dart';
import 'package:cekgizi_mobile/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cekgizi_mobile/app/data/Url/Urls.dart';
import 'package:cekgizi_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:cekgizi_mobile/app/widget/input.dart';
import 'package:cekgizi_mobile/app/widget/button.dart';

class ProfilView extends GetView<ProfileController> {
  ProfilView({super.key});
  int selectedIndex = 2;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController(); // To hold the concatenated code
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Controllers for individual verification code digits
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final Urls urls = Urls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔲 Jarak atas dari safe area ke header
            const SizedBox(height: 20),

            // 🔠 Header "Profil"
            Center(
              child: Text(
                "Profil",
                style: hitamStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 🔲 Jarak antara header dan informasi pengguna
            const SizedBox(height: 30),

            // 👤 Informasi pengguna
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/pp2.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Moh. Fariz",
                        style: hitamStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "mohfariz88@gmail.com",
                        style: hitamStyle.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🔲 Jarak antara profil info dan 3 card
            const SizedBox(height: 20),

            // 🟥🟧🟦 3 Card Warna
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔴 Card Merah
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: warnaMerah,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Umur", // ⬅️ Ganti dengan label sesuai kebutuhan
                          style: hitamStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 🟧 Card Oren
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: warnaOren,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Tinggi Badan", // ⬅️ Ganti dengan label sesuai kebutuhan
                          style: hitamStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 🔵 Card Biru
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: warnaBiru,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Berat Badan", // ⬅️ Ganti dengan label sesuai kebutuhan
                          style: hitamStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔲 Jarak antara card dan menu section
            const SizedBox(height: 15),

            // ⬇️ Section Menu Account & Settings (tanpa card)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔠 Section Account
                      sectionTitle("Account"),

                      menuItem("assets/nama.png", "Detail Profile", () {
                        Get.toNamed(Routes.DETAIL_PROFILE);
                      }),
                      menuItem("assets/edit.png", "Edit Profile", () {
                        Get.toNamed(Routes.EDIT_PROFILE);
                      }),
                      menuItem("assets/lock.png", "Ubah Password", () {
                        _showEmailInputPopup(context);
                      }),

                      const SizedBox(height: 10),

                      // 🔠 Section Settings
                      sectionTitle("Settings"),

                      menuItem("assets/about.png", "Tentang", () {}),
                      menuItem("assets/lonceng.png", "Notifikasi", () {}),
                      menuItem("assets/out.png", "Keluar", () {
                        // Find the LoginController and call its logout method
                        Get.find<LoginController>().logout();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String assetPath, String title, [VoidCallback? onTap]) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Image.asset(
        assetPath,
        width: 22,
        height: 22,
        color: Colors.black87,
      ),
      title: Text(
        title,
        style: hitamStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
      onTap: onTap,
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: hitamStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  void _showEmailInputPopup(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: warnaPutih,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ubah Password",
              style: hitamStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Untuk mendapatkan kode verifikasi masukan email dahulu",
              style: hitamStyle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 20),
            Input(
              w: double.infinity,
              h: 50,
              cekPassword: false,
              icon: "assets/email.png",
              cs: _emailController,
              labelInput: "Email",
            ),
            const SizedBox(height: 20),
            Button(
              w: double.infinity,
              h: 50,
              nama: "Selanjutnya",
              fungsi: () async {
                String email = _emailController.text.trim();

                if (email.isEmpty || !GetUtils.isEmail(email)) {
                  Get.snackbar("Error", "Masukan email yang valid");
                  return;
                }

                try {
                  var response = await http.post(
                    Uri.parse("${urls.url}/auth/mintaKode"),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({'email': email}),
                  );

                  var responseData = jsonDecode(response.body);

                  if (response.statusCode == 200) {
                    Get.back();
                    _showVerificationCodePopup(context, email);
                  } else {
                    Get.snackbar(
                      "Error",
                      responseData['message'] ??
                          "Gagal meminta kode verifikasi",
                    );
                  }
                } catch (e) {
                  Get.snackbar("Error", "Terjadi kesalahan: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVerificationCodePopup(BuildContext context, String email) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: warnaPutih,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kode Verifikasi",
              style: hitamStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Masukan kode verifikasi yang berada di email kamu",
              style: hitamStyle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                // Replace TextField with custom Input widget for each digit
                return SizedBox(
                  width: 50, // Adjust width as needed for your design
                  child: Input(
                    w: 50, // Set width for individual digit input
                    h: 50, // Set height for individual digit input
                    cekPassword: false, // Not a password field
                    icon: "", // No icon for individual digit
                    cs: _codeControllers[index],
                    labelInput: "", // No hint text for individual digit
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Button(
              w: double.infinity, // Match width
              h: 50, // Match height
              nama: "Selanjutnya", // Button text
              fungsi: () async {
                String enteredCode =
                    _codeControllers
                        .map((controller) => controller.text)
                        .join();

                if (enteredCode.length != 4) {
                  Get.snackbar("Error", "Kode verifikasi harus 4 digit");
                  return;
                }

                try {
                  var response = await http.post(
                    Uri.parse("${urls.url}/auth/kodeVerifikasi"),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({'email': email, 'code': enteredCode}),
                  );

                  var responseData = jsonDecode(response.body);

                  if (response.statusCode == 200) {
                    Get.back(); // Close verification code pop-up
                    _showResetPasswordPopup(
                      context,
                      email,
                      enteredCode,
                    ); // Show reset password pop-up
                  } else {
                    Get.snackbar(
                      "Error",
                      responseData['message'] ?? "Verifikasi kode gagal",
                    );
                  }
                } catch (e) {
                  Get.snackbar("Error", "Terjadi kesalahan: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showResetPasswordPopup(
    BuildContext context,
    String email,
    String code,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: warnaPutih,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reset Password",
              style: hitamStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Masukan kata sandi terbaru kamu",
              style: hitamStyle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 20),
            Input(
              w: double.infinity, // Match width
              h: 50, // Match height
              cekPassword: true, // Is a password field
              icon: "assets/lock.png", // Assuming a lock icon asset
              cs: _newPasswordController,
              labelInput: "Password Baru", // Use as hintText
            ),
            const SizedBox(height: 16), // Spacing between password fields
            Input(
              w: double.infinity, // Match width
              h: 50, // Match height
              cekPassword: true, // Is a password field
              icon: "assets/lock.png", // Assuming a lock icon asset
              cs: _confirmPasswordController,
              labelInput: "Konfirmasi Password Baru", // Use as hintText
            ),
            const SizedBox(height: 20),
            Button(
              w: double.infinity, // Match width
              h: 50, // Match height
              nama: "Selanjutnya", // Button text
              fungsi: () async {
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (newPassword != confirmPassword) {
                  Get.snackbar("Error", "Konfirmasi password tidak cocok");
                  return;
                }

                if (newPassword.isEmpty) {
                  Get.snackbar("Error", "Password baru tidak boleh kosong");
                  return;
                }

                try {
                  var response = await http.post(
                    Uri.parse("${urls.url}/auth/resetpassword"),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'email': email,
                      'code': code,
                      'new_password': newPassword,
                    }),
                  );

                  var responseData = jsonDecode(response.body);

                  if (response.statusCode == 200) {
                    Get.back(); // Close reset password pop-up
                    Get.snackbar("Success", responseData['message']);
                    // Optionally navigate to login page after successful password reset
                    // Get.offAllNamed(Routes.LOGIN);
                  } else {
                    Get.snackbar(
                      "Error",
                      responseData['message'] ?? "Gagal mereset password",
                    );
                  }
                } catch (e) {
                  Get.snackbar("Error", "Terjadi kesalahan: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
