import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MasukkanNilaiController extends GetxController {
  List<TextEditingController> niliUtsC = <TextEditingController>[];
  List<TextEditingController> nilaiSemesterC = <TextEditingController>[];
  List<TextEditingController> catananGuruC = <TextEditingController>[];

  List<String> listNilaiUts = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> streamPelajaran() async {
    var waliKelas = await firestore
        .collection("Guru")
        .doc(auth.currentUser!.email)
        .get()
        .then((value) => value.data()?['mengajarKelas']);

    var mataPelajaran =
        firestore.collection("pelajaran").where("kelas", isEqualTo: waliKelas);

    return mataPelajaran.get();
  }

  Future<void> tambahNilaiSiswa(String semester, String email) async {
    List<String> listPelajaran = [];
    List<String> listPelajaranData = [];

    var waliKelas = await firestore
        .collection("Guru")
        .doc(auth.currentUser!.email)
        .get()
        .then((value) => value.data()?['mengajarKelas']);

    var datapelajaran = await firestore
        .collection("pelajaran")
        .where("kelas", isEqualTo: waliKelas)
        .get();
    final mapDataPelajaran = datapelajaran.docs;
    for (var value in mapDataPelajaran) {
      var isiData = value.data();
      listPelajaran.add(isiData['pelajaran']);
    }

    print(waliKelas);
    print(mapDataPelajaran);
    print("data diprintt");
    print(listPelajaran);
    DocumentReference<Map<String, dynamic>> siswa =
        firestore.collection("Siswa").doc();

    List<String> toListPelajaran() {
      listPelajaran.forEach((item) {
        listPelajaranData.add(item.toString());
      });

      return listPelajaranData.toList();
    }

    try {
      await siswa.set({
        "nilai": {
          "$waliKelas": {
            semester: {
              listPelajaran: {0}
            }
          }
        }
      });

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Pelajaran berhasil ditambah",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.donut_large,
          color: Colors.green,
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Gagal menambahkan Nilai Siswa",
        "Coba Berberapa saat lagi ",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }
}
