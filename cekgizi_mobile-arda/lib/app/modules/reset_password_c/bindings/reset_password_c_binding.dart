import 'package:get/get.dart';

import '../controllers/reset_password_c_controller.dart';

class ResetPasswordCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordCController>(
      () => ResetPasswordCController(),
    );
  }
}
