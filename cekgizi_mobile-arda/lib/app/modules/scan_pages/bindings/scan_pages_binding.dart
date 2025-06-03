import 'package:get/get.dart';

import '../controllers/scan_pages_controller.dart';

class ScanPagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanPagesController>(
      () => ScanPagesController(),
    );
  }
}
