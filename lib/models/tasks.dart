import "package:flutter/material.dart";

class Task {
  int id;
  String title;
  bool completed;

  Task({this.id, @required this.title, this.completed = false});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"title": title, "completed": completed == true ? 1 : 0};
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }



  void toggleCompleted() {
    completed = !completed;
  }
}
