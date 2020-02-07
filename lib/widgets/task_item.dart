import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:todos/models/todos.dart';
import 'package:todos/screens/task_add_update.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key key, this.todo}) : super(key: key);

  MaterialPageRoute navigateToUpdateTaskScreen() {
    return MaterialPageRoute(
      builder: (context) => UpdateTodoScreen(todo: todo),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool checked) {
          Provider.of<TodosModel>(context, listen: false)
              .toggleTodo(todo);
        },
      ),
      title: Text(todo.title),
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
                  .deleteTodo(todo);
            },
          ),
        ],
      ),
    );
  }
}

class TodoSizedItem extends StatelessWidget {
  final Todo todo;

  TodoSizedItem({@required this.todo});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final nbCol = mediaQueryWidth / 250;
    if (nbCol > 2) {
      return SizedBox(
          width: mediaQueryWidth / nbCol.floor(), child: TodoItem(todo:todo));
    } else {
      return TodoItem(todo: todo);
    }
  }
}

class AddTodoWidget extends StatefulWidget {
  final Todo todo;
  final String labelBtn;

  AddTodoWidget({@required this.todo, @required this.labelBtn});

  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final taskTitleController = TextEditingController();

  @override
  void initState(){
    taskTitleController.text = widget.todo.title;
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onSubmit() {
    final String textVal = taskTitleController.text;
    final bool completed = widget.todo.completed;
    if (textVal.isNotEmpty) {
      this.widget.todo.title = textVal;
      this.widget.todo.completed = completed;

      TodosModel todosModel = Provider.of<TodosModel>(context, listen: false);
      if (this.widget.todo.id == null){
        todosModel.addTodo(widget.todo);
      }else{
        todosModel.updateTodo(widget.todo);
      }
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
                    onSubmitted: (String text) => onSubmit()),
                CheckboxListTile(
                  value: widget.todo.completed,
                  onChanged: (checked) => setState(() {
                    widget.todo.completed = checked;
                  }),
                  title: Text('Complete?'),
                ),
                RaisedButton(
                  child: Text(this.widget.labelBtn),
                  onPressed: onSubmit,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
