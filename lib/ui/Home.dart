import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/utils/database_helper.dart';

import 'InputPage.dart';
import 'StaggeredGridPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Notes",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: new Scrollbar(child: new StaggeredGridPage()),
      floatingActionButton: new FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue.shade200,
        child: (Builder(builder: (BuildContext context) {
          return new IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              saveNote(context);
            },
          );
        })),
      ),
    );
  }

  void saveNote(BuildContext context) async {
    Map<String, dynamic> result =
        await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new InputPage("save");
    }));
    if (result != null &&
        result["title"] != null &&
        result["title"].length > 0) {
      var db = new DatabaseHelper();
      int res = await db.saveNote(new Note(
        result["title"],
        (result["content"] == null ? "" : result["content"]),
        new DateTime.now(),
        result["color"] == null ? Colors.red.value.toString() : result["color"],
      ));
      var snackbar = new SnackBar(content: new Text("Saved"));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}
