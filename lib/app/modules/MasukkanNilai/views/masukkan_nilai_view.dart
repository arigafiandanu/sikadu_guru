import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/routes/app_pages.dart';

import '../controllers/masukkan_nilai_controller.dart';

class MasukkanNilaiView extends GetView<MasukkanNilaiController> {
  var dataSiswa = Get.arguments;

  List<Tab> myTab = const [
    Tab(
      text: "Semester 1",
    ),
    Tab(
      text: "Semester 2",
    )
  ];

  MasukkanNilaiView({Key? key}) : super(key: key);
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
          'Nilai ${dataSiswa["nama"]}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          DefaultTabController(
            length: myTab.length,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  tabs: myTab,
                ),
                SizedBox(
                  height: Get.height * 0.85,
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  width: Get.width / 2,
                                  child: const Text(
                                    "Mata Pelajaran",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  width: Get.width / 5,
                                  child: const Text(
                                    "Nilai UTS",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  width: Get.width / 5,
                                  child: const Text(
                                    "Nilai Semester",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Get.width / 10,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                stream: controller.streamPelajaran().asBroadcastStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: Text("Waiting Data"),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    var kelas = dataSiswa['kelas'];
                                    var dataNilai = {};
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        var dataPelajaran = data[index].data();
                                        return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: controller.futureGrade(
                                                dataSiswa['email']).asBroadcastStream(),
                                            builder: (context, snapshot2) {
                                              if (snapshot2.hasData) {
                                                var gradeData = snapshot2.data;
                                                var pelajaran =
                                                    dataPelajaran['pelajaran'];
                                                var grade = gradeData?['nilai']
                                                        [kelas]?['semester 1']?
                                                    [pelajaran];

                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 250,
                                                  color: Colors.blue
                                                      .withOpacity(0.05),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 20,
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 2,
                                                            child: Text(
                                                              "${dataPelajaran['pelajaran']}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 5,
                                                            child: Text(
                                                              grade['nilaiUts']
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 5,
                                                            child: Text(
                                                              grade['nilaiSemester']
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              right: 20,
                                                            ),
                                                            width:
                                                                Get.width / 10,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Get.toNamed(
                                                                    Routes
                                                                        .EDIT_NILAI,
                                                                    arguments: {
                                                                      "pelajaran":
                                                                          dataPelajaran[
                                                                              'pelajaran'],
                                                                      "dataSiswa":
                                                                          dataSiswa,
                                                                      "nilaiUts":
                                                                          grade['nilaiUts']
                                                                              .toString(),
                                                                      "nilaiSemester":
                                                                          grade['nilaiSemester']
                                                                              .toString(),
                                                                      "catatanGuru":
                                                                          grade[
                                                                              'catatanGuru'],
                                                                      "semester":
                                                                          "semester 1"
                                                                    });
                                                              },
                                                              icon: Icon(
                                                                Icons.edit,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                          top: 20,
                                                        ),
                                                        width: Get.width,
                                                        child: const Text(
                                                          "Catatan : ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 10,
                                                        ),
                                                        height: Get.width / 5,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 20,
                                                            right: 20,
                                                            top: 10),
                                                        color: Colors.white,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          grade['catatanGuru'],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text("data Kosong"),
                                                );
                                              }
                                            });
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                      //tab nilaisemester

                      Column(
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  width: Get.width / 2,
                                  child: const Text(
                                    "Mata Pelajaran",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  width: Get.width / 5,
                                  child: const Text(
                                    "Nilai UTS",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  width: Get.width / 5,
                                  child: const Text(
                                    "Nilai Semester",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Get.width / 10,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                stream: controller.streamPelajaran().asBroadcastStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: Text("Waiting Data"),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    var kelas = dataSiswa['kelas'];
                                    var dataNilai = {};
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        var dataPelajaran = data[index].data();
                                        return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: controller.futureGrade(
                                                dataSiswa['email']).asBroadcastStream(),
                                            builder: (context, snapshot2) {
                                              if (snapshot2.hasData) {
                                                var gradeData = snapshot2.data;
                                                var pelajaran =
                                                    dataPelajaran['pelajaran'];
                                                var grade = gradeData?['nilai']?
                                                        [kelas]?['semester 2']?[pelajaran];
                                                var gradeUts = grade?['nilaiUts'] ?? 0;
                                                var gradeSemester = grade?['nilaiSemester'] ?? 0;
                                                
                                                print(pelajaran);
                                                print(grade);

                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 250,
                                                  color: Colors.blue
                                                      .withOpacity(0.05),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 20,
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 2,
                                                            child: Text(
                                                              "${dataPelajaran['pelajaran']}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 5,
                                                            child: Text(
                                                              gradeUts.toString()
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                            ),
                                                            width:
                                                                Get.width / 5,
                                                            child: Text(
                                                             gradeSemester.toString()
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              right: 20,
                                                            ),
                                                            width:
                                                                Get.width / 10,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Get.toNamed(
                                                                    Routes
                                                                        .EDIT_NILAI,
                                                                    arguments: {
                                                                      "pelajaran":
                                                                          dataPelajaran[
                                                                              'pelajaran'],
                                                                      "dataSiswa":
                                                                          dataSiswa,
                                                                      "nilaiUts":
                                                                          grade?['nilaiUts']
                                                                              .toString(),
                                                                      "nilaiSemester":
                                                                          grade?['nilaiSemester']
                                                                              .toString(),
                                                                      "catatanGuru":
                                                                          grade?[
                                                                              'catatanGuru'],
                                                                      "semester":
                                                                          "semester 2"
                                                                    });
                                                              },
                                                              icon: Icon(
                                                                Icons.edit,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                          top: 20,
                                                        ),
                                                        width: Get.width,
                                                        child: const Text(
                                                          "Catatan : ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 10,
                                                        ),
                                                        height: Get.width / 5,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 20,
                                                            right: 20,
                                                            top: 10),
                                                        color: Colors.white,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          grade?['catatanGuru'] ?? "Catatan untuk siswa",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text("data Kosong"),
                                                );
                                              }
                                            });
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
