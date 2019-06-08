import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/utils/database_helper.dart';

class InputPage extends StatefulWidget {
  String saveOrEdit;
  Note n;

  InputPage(this.saveOrEdit, [this.n]) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputPageState(saveOrEdit, n);
  }
}

class _InputPageState extends State<InputPage> {
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  String pagetitle;
  Note n;

  _InputPageState(String saveOrEdit, [Note n]) {
    if (saveOrEdit.compareTo("save") == 0) {
      pagetitle = "Add Note";
    } else {
      pagetitle = "Edit Note";
      title.text = n.title;
      content.text = n.content;
      this.n = n;
    }
    list_of_actions.add(Builder(builder: (BuildContext context) {
      return new IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          Navigator.pop(context, {
            "title": title.text,
            "content": content.text,
            "color": color,
          });
        },
        tooltip: "Save Note",
      );
    }));
    list_of_actions.add(Builder(builder: (BuildContext context) {
      return new IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _deleteNote(context, n);
        },
        tooltip: "Delete Note",
      );
    }));
    list_of_actions.add(Builder(builder: (BuildContext context) {
      return new IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          Navigator.pop(context, {
            "title": null,
            "content": null,
            "color": null,
          });
        },
        tooltip: "Save Note",
      );
    }));
  }

  List<Widget> list_of_actions = <Widget>[];
  String color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue.shade200,
          title: new ListTile(
            title: new Text(
              "$pagetitle",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
//          centerTitle: true,
          actions: list_of_actions,
        ),
        backgroundColor: Colors.blueGrey.shade400,
        body: new Scrollbar(
          child: new Container(
            padding: EdgeInsets.all(8.0),
            child: new ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new TextFormField(
                    controller: title,
                    decoration: new InputDecoration(
                      labelText: "Enter title",
                      hintText: "Hello world",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new TextFormField(
                    controller: content,
                    decoration: new InputDecoration(
                      labelText: "Enter description",
                      hintText: "The world is a beautiful place",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ColorPicker(
                    onChanged: (Color value) {
                      color = value.value.toRadixString(16);
                    },
                    color: n == null
                        ? Colors.blue
                        : Color(int.parse(n.color, radix: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new RaisedButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              "title": title.text,
                              "content": content.text,
                              "color": color,
                            });
                          },
                          child: new ListTile(
                            leading: Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            title: new Text(
                              "Save",
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          color: Colors.black,
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(8.0)),
                      new Expanded(
                        child: new RaisedButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              "title": null,
                              "content": null,
                              "color": null,
                            });
                          },
                          child: new ListTile(
                            leading: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            title: new Text(
                              "Cancel",
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _deleteNote(BuildContext context, Note n) {
    if (n != null) {
      var db = new DatabaseHelper();
      db.deleteNote(n, n.id);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }
}
