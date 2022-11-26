import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class BuatPengumumanController extends GetxController {
  TextEditingController judulC = TextEditingController();
  TextEditingController isiC = TextEditingController();

  var kategoriP = "Umum".obs;
  List dataPengumuman = ["Umum", "Pembayaran", "Libur", "Akademik"];
  final ImagePicker picker = ImagePicker();
  List<XFile> imageList = [];
  List<String> downloadUrl = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> tambahPengumuman() async {
    if (judulC.text.isNotEmpty && isiC.text.isNotEmpty) {
      DocumentReference<Map<String, dynamic>> pengumuman =
          firestore.collection("pengumuman").doc();
      var email = auth.currentUser!.email;
      String? namaUser = (await firestore
          .collection("users")
          .doc(email)
          .get()
          .then((value) => value.data()?['nama'])) as String?;
      try {
        for (int i = 0; i < imageList.length; i++) {
          var data = await uplodImage(imageList[i]);
          downloadUrl.add(data.toString());
        }

        pengumuman.set(
          {
            "id": pengumuman.id,
            "judul": judulC.text,
            "isi": isiC.text,
            "pembuat": namaUser,
            "kategori": kategoriP.value,
            "fotoPengumuman": downloadUrl,
            "tanggalBuat": DateTime.now().toIso8601String(),
          },
        );

        judulC.clear();
        isiC.clear();

        Get.back();
        Get.snackbar(
          "Berhasil",
          "Pengumuman berhasil dibuat",
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.donut_large,
            color: Colors.green,
          ),
        );
      } catch (e) {
        Get.snackbar(
          "Gagal membuat pengumuman",
          "Coba Berberapa saat lagi ",
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      }
    } else {
      Get.snackbar(
        "Gagal Menambah kan Pengumuman",
        "Pastikan semua terisi",
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }

  void pickMultiImage() async {
    imageList = (await picker.pickMultiImage()).cast<XFile>();

    if (imageList.isEmpty) {
      return;
    } else {
      update();
    }
  }

  Future<String> uplodImage(XFile image) async {
    var idUser = auth.currentUser!;

    String? user = (await firestore
        .collection("users")
        .doc(idUser.email)
        .get()
        .then((value) => value.data()?['nama'])) as String?;
    final imgTime = DateTime.now().millisecondsSinceEpoch.toString();
    final imgName = image.name;
    File file = File(image.path);

    await storage.ref("pengumuman/$user/$imgTime+$imgName").putFile(file);
    return await storage
        .ref("pengumuman/$user/$imgTime+$imgName")
        .getDownloadURL();
  }
}
