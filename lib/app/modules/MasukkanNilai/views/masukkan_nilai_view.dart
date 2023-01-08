import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/style/textStyle.dart';
import 'package:sikadu_guru/app/widget/buttonW.dart';
import 'package:sikadu_guru/app/widget/textFieldCatatan.dart';
import 'package:sikadu_guru/app/widget/textFieldNilai.dart';

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
                                  width: Get.width / 4,
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
                                  width: Get.width / 4,
                                  child: const Text(
                                    "Nilai Semester",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: FutureBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                future: controller.streamPelajaran(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: Text("Waiting Data"),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;

                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        TextEditingController nilaiUts =
                                            TextEditingController();
                                        // TextEditingController nilaiSemester =
                                        //     TextEditingController();
                                        // TextEditingController catatanGuru =
                                        //     TextEditingController();

                                        controller.niliUtsC.add(nilaiUts);
                                        // controller.nilaiSemesterC
                                        //     .add(nilaiSemester);
                                        // controller.catananGuruC
                                        //     .add(catatanGuru);
                                        controller.listNilaiUts.add(nilaiUts.text.toString());

                                        var dataPelajaran = data[index].data();
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 250,
                                          color: Colors.blue.shade50,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20,
                                                      top: 20,
                                                    ),
                                                    width: Get.width / 2,
                                                    child: Text(
                                                      "${dataPelajaran['pelajaran']}",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    width: Get.width / 4,
                                                    child: TextFormNilai(
                                                      hint: "70",
                                                      controller: nilaiUts,
                                                      readOnly: false,
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           top: 20),
                                                  //   width: Get.width / 4,
                                                  //   child: TextFormNilai(
                                                  //     hint: "89",
                                                  //     controller: nilaiSemester,
                                                  //     readOnly: false,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 20,
                                                ),
                                                width: Get.width,
                                                child: const Text(
                                                  "Catatan : ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   padding: const EdgeInsets.only(
                                              //     left: 20,
                                              //     right: 20,
                                              //     top: 10,
                                              //   ),
                                              //   child: TextFieldCatatan(
                                              //     hint:
                                              //         "Catatan Mata Pelajaran ini",
                                              //     controller: catatanGuru,
                                              //     readOnly: false,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  }
                                }),
                          ),
                          ButtonW(
                            onTap: () {
                              controller.tambahNilaiSiswa("semester 2", dataSiswa["email"]);
                            },
                            text: "Tambah",
                          )
                        ],
                      ),
                      ListView(
                        children: [
                          Container(
                            height: 500,
                            color: Colors.amber,
                          )
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
