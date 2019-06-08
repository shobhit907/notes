import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:notes/ui/Home.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Notes",
//    color: Colors.blue.shade200,
    home: new Home(),
  ));
}
