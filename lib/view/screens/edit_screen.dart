import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/controller.dart';

import '../widgets/custom_text_field.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key, this.id, this.title, this.descroption, this.time});
  final int? id;
  final String? title;
  final String? descroption;
  final String? time;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final timeController = TextEditingController();

  final controller = Get.put(SQLController());

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    if (controller.updatedTaskData) {
      titleController.text = widget.title!;
      descriptionController.text = widget.descroption!;
      timeController.text = widget.time!;
    }
    super.initState();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    ).then((value) => _dateTime = value!);
  }

  @override
  void dispose() {
    controller.updatedTaskData = false;
    super.dispose();
  }

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
              // CustomFormField(
              //     titleController: timeController,
              //     validationText: 'The time must have a value'),
              ElevatedButton(
                onPressed: () => _showDatePicker(),
                child: const Text('Pick date'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    if (!controller.updatedTaskData) {
                      controller.insertData(
                        title: titleController.text,
                        description: descriptionController.text,
                        time: _dateTime.toIso8601String(),
                      );
                    } else {
                      controller.updateData(
                        title: titleController.text,
                        description: descriptionController.text,
                        time: timeController.text,
                        id: widget.id!,
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.red,
                  child: Text(controller.updatedTaskData ? "update" : "add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
