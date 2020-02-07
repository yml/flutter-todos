import 'package:flutter/material.dart';

import 'package:todos/models/todos.dart';

import 'package:todos/widgets/task_item.dart';

class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: AddTodoWidget(todo: Todo(), labelBtn: "Add"));
  }
}

class UpdateTodoScreen extends StatelessWidget {
  final Todo todo;

  UpdateTodoScreen({@required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Task'),
        ),
        body: AddTodoWidget(
          todo: todo,
          labelBtn: "Update",
        ));
  }
}
