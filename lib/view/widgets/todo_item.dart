import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/view/screens/edit_screen.dart';

import '../../controller/controller.dart';
import '../../model/todo.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.controller,
  });

  final TodoModel todo;
  final SQLController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(child: Text(todo.title)),
                  Expanded(child: Text(todo.time)),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(todo.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.deleteData(todo.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.updatedTaskData = true;
                      Get.to(EditScreen());
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
