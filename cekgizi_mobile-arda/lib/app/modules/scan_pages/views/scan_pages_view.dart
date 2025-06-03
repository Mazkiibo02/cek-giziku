import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_pages_controller.dart';

class ScanPagesView extends GetView<ScanPagesController> {
  const ScanPagesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanPagesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanPagesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
