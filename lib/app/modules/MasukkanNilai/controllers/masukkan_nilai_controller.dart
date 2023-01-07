import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MasukkanNilaiController extends GetxController {


    List<TextEditingController> niliUtsC = <TextEditingController>[];
        List<TextEditingController> nilaiSemesterC = <TextEditingController>[];


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
