import 'package:cekgizi_mobile/app/data/Url/Urls.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

import 'package:cekgizi_mobile/firebase_background_handler.dart';
import 'package:http/http.dart' as http;

class NotifControllerController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("📲 FCM Token: $token");

      if (token != null) {
        await kirimTokenKeBackend(token);
      }

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    }
  }

  Future<void> kirimTokenKeBackend(String fcmToken) async {
    final box = GetStorage();
    final jwtToken = box.read("token");

    if (jwtToken == null) return;

    try {
      final response = await http.post(
        Uri.parse("${Urls().url}/makanan/simpan-fcm-token"),
        headers: {
          "Authorization": "Bearer $jwtToken",
          "Content-Type": "application/json",
        },
        body: '{"fcm_token": "$fcmToken"}',
      );

      if (response.statusCode == 200) {
        print("✅ Token berhasil dikirim");
      } else {
        print("❌ Gagal kirim token: ${response.body}");
      }
    } catch (e) {
      print("❌ Error kirim token: $e");
    }
  }

  Future<void> setupNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Minta izin notifikasi
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    // Cek jika user mengizinkan
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Dapatkan token FCM
      String? token = await messaging.getToken();
      print("📲 FCM Token: $token");

      if (token != null) {
        await kirimTokenKeBackend(token); // Fungsi kamu sendiri
      }

      // Listener saat app sedang dibuka (foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
          '📥 Pesan diterima di foreground: ${message.notification?.title}',
        );
      });

      // Listener saat app di background/terminated
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } else {
      print("❌ Izin notifikasi tidak diberikan");
    }
  }
}
