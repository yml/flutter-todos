import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:provider/provider.dart';

import 'package:todos/screens/home.dart';
import 'package:todos/providers/todos.dart';
import 'package:todos/providers/settings.dart';
import 'package:todos/providers/database.dart';

void main() {
  DatabaseProvider dbProvider = DatabaseProvider();

  runApp(TodosApp(dbProvider: dbProvider));
}

class TodosApp extends StatefulWidget {
  final DatabaseProvider dbProvider;

  TodosApp({this.dbProvider, Key key}) : super(key: key);

  @override
  _TodosAppState createState() => _TodosAppState();
}

class _TodosAppState extends State<TodosApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    closeDatabase();
    super.dispose();
  }

  void closeDatabase() async {
    Database db = await this.widget.dbProvider.database;
    db.close();
  }


  TodosModel getTodoModel() {
    return TodosModel(dbProvider: this.widget.dbProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getTodoModel()),
        ChangeNotifierProvider(create: (context) => SettingsModel()),
      ],
      child: Consumer<SettingsModel>(builder: (context, settings, child) {
        return MaterialApp(
          title: 'Todos',
          // theme: ThemeData.dark(),
          theme: settings.getTheme(),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
