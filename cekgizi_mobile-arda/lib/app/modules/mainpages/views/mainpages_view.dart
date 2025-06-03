import 'package:cekgizi_mobile/app/modules/home_page/views/home_page_view.dart';
import 'package:cekgizi_mobile/app/modules/profile/views/profile_view.dart';
import 'package:cekgizi_mobile/app/modules/scan_pages/views/scan_pages_view.dart';
import 'package:cekgizi_mobile/app/widget/CustomNavbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mainpages_controller.dart';

class MainpagesView extends GetView<MainpagesController> {
  const MainpagesView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomePageView(), ScanPagesView(), ProfilView()];

    return Obx(
      () => Scaffold(
        body: IndexedStack(index: controller.index.value, children: pages),
        bottomNavigationBar: CustomNavbar(
          currentIndex: controller.index.value,
          onTap: controller.ubahIndex,
        ),
      ),
    );
  }
}
