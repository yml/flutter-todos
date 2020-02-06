import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:todos/models/tasks.dart';
import 'package:todos/providers/todos.dart';
import 'package:todos/screens/addtask.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({Key key, this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  MaterialPageRoute navigateToUpdateTaskScreen() {
    return MaterialPageRoute(
      builder: (context) => UpdateTaskScreen(task: widget.task),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.task.completed,
        onChanged: (bool checked) {
          Provider.of<TodosModel>(context, listen: false)
              .toggleTodo(widget.task);
        },
      ),
      title: Text(widget.task.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                navigateToUpdateTaskScreen(),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              Provider.of<TodosModel>(context, listen: false)
                  .deleteTodo(widget.task);
            },
          ),
        ],
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
      return SizedBox(
          width: mediaQueryWidth / nbCol.floor(), child: TaskItem(task:task));
    } else {
      return TaskItem(task: task);
    }
  }
}

class AddTaskWidget extends StatefulWidget {
  final Task task;

  AddTaskWidget({@required this.task});

  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final taskTitleController = TextEditingController();

  @override
  void initState(){
    taskTitleController.text = widget.task.title;
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = widget.task.completed;
    if (textVal.isNotEmpty) {
      final Task todo = Task(
        title: textVal,
        completed: completed,
      );
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                    controller: taskTitleController,
                    onSubmitted: (String text) => onAdd()),
                CheckboxListTile(
                  value: widget.task.completed,
                  onChanged: (checked) => setState(() {
                    widget.task.completed = checked;
                  }),
                  title: Text('Complete?'),
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: onAdd,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
