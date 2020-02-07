import 'package:flutter/material.dart';

import 'package:todos/models/todos.dart';
import 'package:todos/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  final List<Todo> todos;

  TaskList({@required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }

  List<Widget> getChildrenTasks() {
    return todos.map((todo) => TaskItem(todo: todo)).toList();
  }
}


class TaskWrapGrid extends StatelessWidget {
  final List<Todo> tasks;

  TaskWrapGrid({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(
      children: getChildrenTasks(),
    ));
  }

  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => TaskSizedItem(task: todo)).toList();
  }
}
