import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/view/screens/edit_screen.dart';

import '../../controller/controller.dart';
import '../../model/todo.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final control = Get.put(SQLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo App'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const EditScreen()),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<SQLController>(builder: (controller) {
        return ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (context, index) {
            TodoModel todo = controller.list[index];
            return TodoItemWidget(todo: todo, controller: controller);
          },
        );
      }),
    );
  }
}
