import 'package:cekgizi_mobile/app/controllers/notif_controller_controller.dart';
import 'package:get/get.dart';

import '../controllers/mainpages_controller.dart';
import '../../login/controllers/login_controller.dart';

class MainpagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpagesController>(() => MainpagesController());
    Get.put(NotifControllerController());
  }
}
