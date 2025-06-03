import 'package:cekgizi_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:cekgizi_mobile/app/modules/scan_pages/controllers/scan_pages_controller.dart';
import 'package:get/get.dart';
import 'package:cekgizi_mobile/app/modules/home_page/controllers/home_page_controller.dart';

class MainpagesController extends GetxController {
  //TODO: Implement MainpagesController
  final index = 0.obs;

  void ubahIndex(int iss) {
    index.value = iss;
    switch (iss) {
      case 0:
        if (!Get.isRegistered<HomePageController>()) {
          Get.lazyPut(() => HomePageController);
        }
        break;
      case 1:
        if (!Get.isRegistered<ScanPagesController>()) {
          Get.lazyPut(() => ScanPagesController());
        }
        break;
      case 2:
        if (!Get.isRegistered<ProfileController>()) {
          Get.lazyPut(() => ProfileController());
        }
        break;
    }
  }
}
