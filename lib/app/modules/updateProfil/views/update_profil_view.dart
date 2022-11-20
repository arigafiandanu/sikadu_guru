import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profil_controller.dart';

class UpdateProfilView extends GetView<UpdateProfilController> {
  const UpdateProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateProfilView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateProfilView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
