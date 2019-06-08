import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/utils/database_helper.dart';
import 'ListViewPage.dart';
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
  dynamic toggle=new StaggeredGridPage();
  String curr="s";
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
          new IconButton(tooltip: "Toggle View",icon: Icon(Icons.shuffle,color: Colors.white,), onPressed: (){
            _handleToggle();
          })
        ],
      ),
      drawer: new Drawer(

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
      var snackbar = new SnackBar(content: new Text("Saved"),duration: new Duration(seconds: 1),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
    else
      {
        var snackbar = new SnackBar(content: new Text("Not Saved"),duration: new Duration(seconds: 1),);
        Scaffold.of(context).showSnackBar(snackbar);
      }
  }

  void _handleToggle() {
    setState(() {
      if(curr=="s")
        {
          curr="l";
          toggle=new ListViewPage();
        }
      else
        {
          curr="s";
          toggle=new StaggeredGridPage();
        }
    });
  }
}
