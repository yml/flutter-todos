import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todos/screens/homepage.dart';
import 'package:todos/models/todos.dart';
import 'package:todos/models/settings.dart';
import 'package:todos/services/database.dart';

void main() {
  DatabaseProvider dbProvider = DatabaseProvider();

  runApp(TodosApp(dbProvider: dbProvider));
}

class TodosApp extends StatelessWidget {
  final DatabaseProvider dbProvider;

  TodosApp({this.dbProvider, Key key}) : super(key: key);

  TodosModel getTodoModel() {
    return TodosModel(dbProvider: dbProvider);
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
