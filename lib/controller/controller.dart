import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class SQLController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  void createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    openAppDatabase(path: path);
  }

  void openAppDatabase({required String path}) async {
    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Todo (id INTERGER PRIMARY KEY, title TEXT, description TEXT, time favourite INTEGER, completed INTERGER)');
      },
      onOpen: (Database db) {
        debugPrint("Database is open!");
      },
    );
  }
}
