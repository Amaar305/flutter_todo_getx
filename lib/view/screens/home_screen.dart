import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final controller = Get.put(SQLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo App'),
      ),
    );
  }
}
