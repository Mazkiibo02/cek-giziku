import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Removed Get.lazyPut for LoginController
    // Get.lazyPut<LoginController>(() => LoginController());
  }
}
