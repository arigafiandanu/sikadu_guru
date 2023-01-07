import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/detail_profil_controller.dart';

class DetailProfilView extends GetView<DetailProfilController> {
  var infoProfil = Get.arguments;
  DetailProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          '${infoProfil['nama'].toUpperCase()}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                width: 180,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: infoProfil!['foto'] != "foto kosong"
                      ? Image.network(
                          infoProfil['foto'],
                          fit: BoxFit.cover,
                        )
                      : Lottie.asset(
                          "assets/lottie/avatar.json",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
