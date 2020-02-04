import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todos/providers/settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change settings'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Dark Mode",
                ),
                Consumer<SettingsModel>(builder:(context,settings,child) {
                   return Switch(
                     value: settings.isThemeDark(),
                      onChanged: (_)=>settings.toggleTheme(),
                      );
                },
                ),
              ],
                
            )
          ],
        ));
  }
}
