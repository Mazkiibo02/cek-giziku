import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../../login/controllers/login_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
