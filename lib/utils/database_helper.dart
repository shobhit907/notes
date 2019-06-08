import 'dart:io';

import 'package:notes/models/Note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String database_name = "notes.db";
  String table_name = "notes";
  String id = "id";
  String title = "title";
  String content = "content";
  String date_created = "date_created";
  String color = "color";
  static Database _db;
  var field_map = {
    "id": "INTEGER PRIMARY KEY",
    "title": "TEXT",
    "content": "TEXT",
    "date_created": "INTEGER",
    "color": "TEXT",
  };

  Future<Database> get db async {
    if (_db != null) {

      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "$database_name");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int version) async {
    String query = "";
    field_map.forEach((String key, String value) {
      query += key + " " + value + ",";
    });
    query = query.substring(0, query.length - 1);
    await db.execute("CREATE TABLE $table_name($query)");
  }

  Future<int> saveNote(Note n) async {
    var dbClient = await db;
    return dbClient.insert(table_name, n.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var dbClient = await db;
    var all_notes = dbClient.query(table_name, orderBy: "$date_created DESC");
    return all_notes;
  }

  Future<int> deleteNote(Note n,int id_reqd) async{
    var dbClient=await db;
    return dbClient.delete(table_name,where: "$id = $id_reqd");
  }
  Future<int> updateNote(Note n,int id_reqd) async{
    var dbClient=await db;
    return dbClient.update(table_name, n.toMap(),where: "$id = $id_reqd");
  }
  Future<int> totalNotes() async{
    List l=await getAllNotes();
    return l.length;
  }
  Future<Note> getNote(int id_reqd) async{
    var dbClient=await db;
    var note=Note.fromMap((await dbClient.query(table_name,where: "$id=$id_reqd"))[0]);
    return note;
  }
 }
