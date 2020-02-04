import 'package:flutter/material.dart';

import 'package:todos/models/tasks.dart';
import 'package:todos/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }

  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => TaskItem(task: todo)).toList();
  }
}