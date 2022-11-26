import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_pegumuman_controller.dart';

class ListPegumumanView extends GetView<ListPegumumanController> {
  const ListPegumumanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListPegumumanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ListPegumumanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
