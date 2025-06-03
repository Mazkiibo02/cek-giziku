import 'package:get/get.dart';

import '../controllers/reset_password_pb_controller.dart';

class ResetPasswordPbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordPbController>(
      () => ResetPasswordPbController(),
    );
  }
}
