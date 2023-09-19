import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/controller.dart';

import '../widgets/custom_text_field.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, this.id, this.title, this.descroption, this.time});
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final int? id;
  final String? title;
  final String? descroption;
  final String? time;

  final controller = Get.put(SQLController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.updatedTaskData ? "update task" : "add task"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomFormField(
                  titleController: titleController,
                  validationText: 'The title must have a value'),
              CustomFormField(
                  titleController: descriptionController,
                  validationText: 'Description must have a value'),
              CustomFormField(
                  titleController: timeController,
                  validationText: 'The time must have a value'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    if (!controller.updatedTaskData) {
                      controller.insertData(
                        title: titleController.text,
                        description: descriptionController.text,
                        time: timeController.text,
                      );
                    } else {
                      controller.updateData(
                        title: titleController.text,
                        description: descriptionController.text,
                        time: timeController.text,
                        id: id!,
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.red,
                  child: Text(controller.updatedTaskData ? "update" : "add"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
