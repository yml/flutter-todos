import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import "package:todos/models/tasks.dart";
import 'package:todos/providers/database.dart';

class TodosModel extends ChangeNotifier {
  final DatabaseProvider dbProvider;
  Database db;

  List<Task> _tasks = [];

  TodosModel({this.dbProvider}) {
    _setupDatabase();
  }

  _setupDatabase() async {
    DatabaseProvider dpProvider = DatabaseProvider();
    db = await dpProvider.database;
    getAllTodos();
  }

  // final List<Task> _tasks = [];a

  UnmodifiableListView<Task> get allTasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(allTasks.where((todo) => !todo.completed));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(allTasks.where((todo) => todo.completed));

  void getAllTodos() async {
    final List<Map<String, dynamic>> maps = await db.query(todoTABLE);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    if (maps != null) {
      _tasks = List.generate(maps.length, (i) {
        return Task(
          id: maps[i][todoColumnId],
          title: maps[i][todoColumnTitle],
          completed: (maps[i][todoColumnCompleted] == 0) ? false : true,
        );
      });
    }
    notifyListeners();
  }

  void addTodo(Task task) async {
    task.id = await db.insert(todoTABLE, task.toMap());
    print("addTodo : ${task.id}");
    getAllTodos();
  }

  void toggleTodo(Task task) async {
    task.toggleCompleted();
    int id = await db
        .update(todoTABLE, task.toMap(), where: "$todoColumnId = ?", whereArgs: [task.id]);
    print("toggleTodo: $id");
    getAllTodos();
  }

  void deleteTodo(Task task) async {
    await db.delete(todoTABLE, where: '$todoColumnId = ?', whereArgs: [task.id]);
    getAllTodos();
  }
}
