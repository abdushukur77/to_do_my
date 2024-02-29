import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:to_do_my/data/local/category/category_model.dart';
import 'package:to_do_my/data/local/category/category_model_constants.dart';
import 'package:to_do_my/data/local/taskmodel_constants.dart';

import '../task_model.dart';

class LocalDatabase {
  //step 1
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  //Step2

  Database? _database;

  //Step3

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("todo.db");

      return _database!;
    }
  }

  //Step4

  Future<Database> _init(String databaseName) async {
    //......Android/data
    String internalPath = await getDatabasesPath();

    //.... Android/data/todo.db
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //----------------READYYYYYYYYYYYYYYYYYYYYYYYYY

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    await db.execute('''CREATE TABLE ${TaskModelConstants.tableName}(
    
    ${TaskModelConstants.id} $idType,
      ${TaskModelConstants.title} $textType,
      ${TaskModelConstants.description} $textType,
      ${TaskModelConstants.deadline} $textType,
      ${TaskModelConstants.status} $textType,
      ${TaskModelConstants.category} $textType,
      ${TaskModelConstants.priority} $intType
     )''');




    await db.execute('''CREATE TABLE ${CategoryModelConstants.tableName}(
      ${CategoryModelConstants.id} $idType,
      ${CategoryModelConstants.name} $textType,
      ${CategoryModelConstants.color} $textType,
      ${CategoryModelConstants.iconPath} $textType
      )''');


  }


  static Future<CategoryModel> insertCategory(CategoryModel categoryModel) async {

    final db = await databaseInstance.database;
    int savedCategoryID =
    await db.insert(CategoryModelConstants.tableName, categoryModel.toJson());

debugPrint("Category ID ${(savedCategoryID.toString())}");
    return categoryModel.copyWith(id: savedCategoryID);

  }

  static Future<List<CategoryModel>> getAllCategory() async {
    final db = await databaseInstance.database;
    String orderBy = "${CategoryModelConstants.id} DESC";
    List json = await db.query(CategoryModelConstants.tableName, orderBy: orderBy);

    return json.map((e) => CategoryModel.fromJson(e)).toList();
  }

  static Future<int> deleteCategory(int id) async {
    final db = await databaseInstance.database;

    int deletedId = await db.delete(
      CategoryModelConstants.tableName,
      where: "${CategoryModelConstants.id}=?",
      whereArgs: [id],
    );
    return deletedId;
  }




















  ////////////-----------------Tasks

  static Future<TaskModel> insertTask(TaskModel taskModel) async {

    final db = await databaseInstance.database;
    int savedTaskID =
    await db.insert(TaskModelConstants.tableName, taskModel.toJson());

    return taskModel.copyWith(id: savedTaskID);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    final db = await databaseInstance.database;
    String orderBy = "${TaskModelConstants.id} DESC";
    List json = await db.query(TaskModelConstants.tableName, orderBy: orderBy);

    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

  static Future<int> deleteTask(int id) async {
    final db = await databaseInstance.database;

    int deletedId = await db.delete(
      TaskModelConstants.tableName,
      where: "${TaskModelConstants.id}=?",
      whereArgs: [id],
    );
    return deletedId;
  }

  static Future<int> updateTask(TaskModel taskModel,
      int id) async {
    final db = await databaseInstance.database;
    int updatedTaskId = await db.update(
      TaskModelConstants.tableName,
      taskModel.toJson(),
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [id],
    );

    return updatedTaskId;
  }

  static Future<int> updateTaskStatus({
    required String newStatus,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updatedTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.status: newStatus},
      where: "${TaskModelConstants.id}=?",
      whereArgs: [taskId],
    );

    return updatedTaskId;
  }

  static Future<List<TaskModel>> searchTasks(String query) async {
    final db = await databaseInstance.database;
    var json = await db.query(
      TaskModelConstants.tableName,
      where: "${TaskModelConstants.description} LIKE ?",
      whereArgs: ["$query%"],
    );
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

}
