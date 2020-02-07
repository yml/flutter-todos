import 'package:flutter/material.dart';

import 'package:todos/models/todos.dart';

import 'package:todos/widgets/task_item.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: AddTaskWidget(task: Todo()));
  }
}

class UpdateTaskScreen extends StatelessWidget {
  final Todo task;

  UpdateTaskScreen({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Task'),
        ),
        body: AddTaskWidget(task: task));
  }
}
