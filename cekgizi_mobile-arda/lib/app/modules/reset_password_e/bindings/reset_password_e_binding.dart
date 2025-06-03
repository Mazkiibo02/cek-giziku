import 'package:get/get.dart';

import '../controllers/reset_password_e_controller.dart';

class ResetPasswordEBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordEController>(
      () => ResetPasswordEController(),
    );
  }
}
