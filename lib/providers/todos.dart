import 'dart:collection';

import 'package:flutter/material.dart';
import "package:todos/models/tasks.dart";

class TodosModel extends ChangeNotifier {
  // final List<Task> _tasks = [];
  final List<Task> _tasks = [
    Task(title: 'Finish app'),
    Task(title: 'reformat portfolio'),
    Task(title: 'task 3'),
    Task(title: 'task 4'),
  ];

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => !todo.completed));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed));

  void addTodo(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTodo(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
