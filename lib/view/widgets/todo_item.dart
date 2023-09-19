import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notepad/view/screens/edit_screen.dart';

import '../../controller/controller.dart';
import '../../model/todo.dart';

class TodoItemWidget extends StatelessWidget {
  TodoItemWidget({
    super.key,
    required this.todo,
    required this.controller,
  });

  final TodoModel todo;
  final SQLController controller;
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.fetchByFav(),
      child: Card(
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
                    Expanded(
                        child:
                            Text(formatter.format(DateTime.parse(todo.time)))),
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
                        if (todo.favourite == 0) {
                          controller.updateFavData(todo.id, 1);
                        } else {
                          controller.updateFavData(todo.id, 0);
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: todo.favourite == 0 ? Colors.black : Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.updatedTaskData = true;
                        Get.to(
                            () => EditScreen(
                                  id: todo.id,
                                  title: todo.title,
                                  descroption: todo.description,
                                  time: todo.time,
                                ),
                            transition: Transition.cupertino);
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
      ),
    );
  }
}
