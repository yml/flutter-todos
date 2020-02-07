import 'package:flutter/material.dart';

import 'package:todos/models/todos.dart';
import 'package:todos/widgets/task_item.dart';

class TaskWrapGrid extends StatelessWidget {
  final List<Todo> todos;

  TaskWrapGrid({@required this.todos});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(
      children: getChildrenTasks(),
    ));
  }

  List<Widget> getChildrenTasks() {
    return todos.map((todo) => TodoSizedItem(todo: todo)).toList();
  }
}
