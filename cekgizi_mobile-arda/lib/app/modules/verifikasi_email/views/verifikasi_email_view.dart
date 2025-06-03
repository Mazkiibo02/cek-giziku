import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verifikasi_email_controller.dart';

class VerifikasiEmailView extends GetView<VerifikasiEmailController> {
  const VerifikasiEmailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VerifikasiEmailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VerifikasiEmailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
