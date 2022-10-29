import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ganti_password_controller.dart';

class GantiPasswordView extends GetView<GantiPasswordController> {
  const GantiPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GantiPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GantiPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
