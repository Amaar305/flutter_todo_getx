import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../model/todo.dart';

class SQLController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  late Database database;

  void deleteTheDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    await deleteDatabase(path);
    update();
  }

  void createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    openAppDatabase(path: path);
    update();
  }

  void openAppDatabase({required String path}) async {
    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, time TEXT, favourite INTEGER, completed INTERGER)');
        debugPrint("Database is created!");
      },
      onOpen: (Database db) {
        database = db;
        getAllData();
        debugPrint("Database is open!");
      },
    );
  }

  List<TodoModel> list = [];
  void getAllData() async {
    list = [];
    final allData = await database.query('todo');

    for (var data in allData) {
      list.add(TodoModel.fromJson(data));
    }
    debugPrint("$allData");
    update();
  }

  void insertData({
    required String title,
    required String description,
    required String time,
  }) async {
    try {
      await database.insert('todo', {
        'title': title,
        'description': description,
        'time': time,
        'favourite': 0,
        'completed': 0,
      });
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
    getAllData();
    update();
  }

  bool updatedTaskData = false;
  void updateData({
    required String title,
    required String description,
    required String time,
    required int id,
  }) async {
    try {
      await database.update(
        'todo',
        {
          'title': title,
          'description': description,
          'time': time,
          'favourite': 0,
          'completed': 0,
        },
        where: 'id = ${1}',
      );
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
    getAllData();
    update();
  }

  void updateCompleteData(int id, int completed) async {
    await database.update(
      'todo',
      {
        'completed': completed,
      },
      where: 'id = $id',
    );
    getAllData();
    update();
  }

  void deleteData(int id) async {
    await database.delete('todo', where: "id = $id");
    getAllData();
    update();
  }
}
