import 'package:flutter/material.dart';

import 'package:todos/models/tasks.dart';
import 'package:todos/widgets/task_item.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: AddTaskWidget(task: Task()));
  }
}

class UpdateTaskScreen extends StatelessWidget {
  final Task task;

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
