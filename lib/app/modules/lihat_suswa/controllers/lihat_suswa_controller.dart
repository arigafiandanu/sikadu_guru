import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LihatSuswaController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamSiswa() {
    // final String? kelas = firestore
    //     .collection("users")
    //     .doc(auth.currentUser?.email)
    //     .collection('Data Guru')
    //     .doc(auth.currentUser?.email)
    //     .get()
    //     .then((value) => value.data()?['MengajarKelas']) as String?;
    // print("kelass");
    // print(kelas);

    Query<Map<String, dynamic>> siswa =
        firestore.collection("users").where('role', isEqualTo: 'orangTua');
    
    // siswa.snapshots().map((data) => firestore.collection("Data Guru").where('kelas', isEqualTo: kelas));

    return siswa.snapshots();
  }
}
