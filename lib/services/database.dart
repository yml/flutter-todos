import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final todoTABLE = 'todos';
final todoColumnId = 'id';
final todoColumnTitle = "title";
final todoColumnCompleted = "completed";

class DatabaseProvider {

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    //"ReactiveTodo.db is our database instance name
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "flutter_todo.db");
    // await deleteDatabase(dbPath);
    var database = await openDatabase(dbPath,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);

    print("createDatabase");
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $todoTABLE ("
        "$todoColumnId INTEGER PRIMARY KEY, "
        "$todoColumnTitle TEXT, "
        /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "$todoColumnCompleted INTEGER "
        ")");
    print("initDB");
  }
}
