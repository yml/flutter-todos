import 'dart:collection';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import "package:todos/models/tasks.dart";
import "package:todos/providers/database.dart";

class TodosModel extends ChangeNotifier {
  Database db;

  @override
  void dispose() {
    if (db != null) {
      db.close();
    }
    super.dispose();
  }

  List<Task> _tasks = [];

  TodosModel() {
    _setupDatabase();
  }

  _setupDatabase() async {
    DatabaseProvider dpProvider = DatabaseProvider();
    db = await dpProvider.database;
  }

  // final List<Task> _tasks = [];a

  UnmodifiableListView<Task> get allTasks =>
    UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(allTasks.where((todo) => !todo.completed));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(allTasks.where((todo) => todo.completed));

  void getAllTodos() async {
    final List<Map<String, dynamic>> maps = await db.query('todos');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    if (maps != null) {
      _tasks = List.generate(maps.length, (i) {
        return Task(
          id: maps[i]['id'],
          title: maps[i]['title'],
          completed: (maps[i]['completed'] == 0) ? false : true,
        );
      });
    }
    notifyListeners();
  }


  void addTodo(Task task) async {
    task.id = await db.insert("todos", task.toMap());
    print("addTodo : ${task.id}");
    getAllTodos();
  }

  void toggleTodo(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }


  void deleteTodo(Task task) async {
    await db.delete("todos", where: 'id = ?', whereArgs: [task.id]);
    getAllTodos();
  }
}
