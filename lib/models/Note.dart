import 'package:flutter/material.dart';

class Note {
  int id;
  String title;
  String content;
  DateTime date_created;
  String color;

  Note(this.title, this.content, this.date_created,this.color);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = new Map();
    if (id != null) {
      m["id"] = id;
    }
    m["title"] = title;
    m["content"] = content;
    m["date_created"] = date_created.millisecondsSinceEpoch;
    m["color"] = color;
    return m;
  }

  Note.fromMap(Map<String, dynamic> m) {
    id = m["id"];
    title = m["title"];
    content = m["content"];
    date_created=new DateTime.fromMillisecondsSinceEpoch(m["date_created"]);
    color = m["color"];
  }
}
