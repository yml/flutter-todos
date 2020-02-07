import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todos/models/todos.dart';
import 'package:todos/widgets/task_list.dart';

class AllTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) { 
          return TaskWrapGrid(
              tasks: todos.allTasks,
            );
        },
      ),
    );
  }
}


class CompletedTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) => TaskWrapGrid(
              tasks: todos.completedTasks,
            ),
      ),
    );
  }
}


class IncompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) => TaskWrapGrid(
              tasks: todos.incompleteTasks,
            ),
      ),
    );
  }
}