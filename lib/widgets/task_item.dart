import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todos/models/tasks.dart';
import 'package:todos/providers/todos.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (bool checked) {
          Provider.of<TodosModel>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}

class TaskSizedItem extends StatelessWidget {
  final Task task;

  TaskSizedItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final nbCol = mediaQueryWidth / 250;
    if (nbCol > 2) {
        return SizedBox(width: mediaQueryWidth / nbCol.floor(), child: TaskItem(task: task));
    } else {
      return TaskItem(task: task);
    }
  }
}

