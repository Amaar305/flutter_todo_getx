import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

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

  void getAllData() async {
    var allData = await database.query('todo');
    debugPrint("$allData");
  }

  void insertData() async {
    var insert = await database.insert('todo', {
      'title': 'go',
      'description': 'go to school',
      'time': '10',
      'favourite': 0,
      'completed': '',
    });
    debugPrint("$insert: data inserted");
    getAllData();
    update();
  }

  void deleteData() {}
  void updateData() {}
}
