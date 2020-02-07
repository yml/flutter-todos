import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos/services/database.dart';

class Todo {
  int id;
  String title;
  bool completed;

  Todo({this.id, this.title, this.completed = false});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "completed": completed == true ? 1 : 0
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  void toggleCompleted() {
    completed = !completed;
  }
}

class TodosModel extends ChangeNotifier {
  final DatabaseProvider dbProvider;
  Database db;

  List<Todo> _tasks = [];

  TodosModel({this.dbProvider}) {
    _setupDatabase();
  }

  _setupDatabase() async {
    DatabaseProvider dpProvider = DatabaseProvider();
    db = await dpProvider.database;
    getAllTodos();
  }

  // final List<Task> _tasks = [];a

  UnmodifiableListView<Todo> get allTasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Todo> get incompleteTasks =>
      UnmodifiableListView(allTasks.where((todo) => !todo.completed));
  UnmodifiableListView<Todo> get completedTasks =>
      UnmodifiableListView(allTasks.where((todo) => todo.completed));

  void getAllTodos() async {
    final List<Map<String, dynamic>> maps = await db.query(todoTABLE);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    if (maps != null) {
      _tasks = List.generate(maps.length, (i) {
        return Todo(
          id: maps[i][todoColumnId],
          title: maps[i][todoColumnTitle],
          completed: (maps[i][todoColumnCompleted] == 0) ? false : true,
        );
      });
    }
    notifyListeners();
  }

  void addTodo(Todo task) async {
    task.id = await db.insert(todoTABLE, task.toMap());
    print("addTodo : ${task.id}");
    getAllTodos();
  }

  void updateTodo(Todo task) async {
    int id = await db.update(todoTABLE, task.toMap(),
        where: "$todoColumnId = ?", whereArgs: [task.id]);
    print("updateTodo: $id");
    getAllTodos();
  }

  void toggleTodo(Todo task) async {
    task.toggleCompleted();
    int id = await db.update(todoTABLE, task.toMap(),
        where: "$todoColumnId = ?", whereArgs: [task.id]);
    print("toggleTodo: $id");
    getAllTodos();
  }

  void deleteTodo(Todo task) async {
    await db
        .delete(todoTABLE, where: '$todoColumnId = ?', whereArgs: [task.id]);
    getAllTodos();
  }
}
