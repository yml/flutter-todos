import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:todos/providers/settings.dart';

import 'package:todos/screens/home.dart';
import 'package:todos/providers/todos.dart';

void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>  TodosModel()),
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
