import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/utils/database_helper.dart';

import 'AboutPage.dart';
import 'InputPage.dart';
import 'ListViewPage.dart';
import 'StaggeredGridPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  dynamic toggle = new StaggeredGridPage();
  String curr = "s";

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
        actions: <Widget>[
          new IconButton(
              tooltip: "Toggle View",
              icon: Icon(
                Icons.shuffle,
                color: Colors.white,
              ),
              onPressed: () {
                _handleToggle();
              })
        ],
      ),
      drawer: new Drawer(
        child: Container(
          color: Colors.blue.shade100,
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
                child: new Text(
                  "Hello User",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue.shade200,
                ),
              ),
              new ListTile(
                title: new Text("About"),
                onTap: () {
                  _handleAbout(context);
                },
                leading: new Icon(Icons.person),
              )
            ],
          ),
        ),
      ),
      body: new Scrollbar(child: toggle),
      floatingActionButton: new FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade200,
        child: (Builder(builder: (BuildContext context) {
          return new IconButton(
            tooltip: "Add Note",
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
      var snackbar = new SnackBar(
        content: new Text("Saved"),
        duration: new Duration(seconds: 1),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      var snackbar = new SnackBar(
        content: new Text("Not Saved"),
        duration: new Duration(seconds: 1),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  void _handleToggle() {
    setState(() {
      if (curr == "s") {
        curr = "l";
        toggle = new ListViewPage();
      } else {
        curr = "s";
        toggle = new StaggeredGridPage();
      }
    });
  }

  void _handleAbout(BuildContext context) async {
    Navigator.pop(context);
    await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AboutPage();
    }));
  }
}
