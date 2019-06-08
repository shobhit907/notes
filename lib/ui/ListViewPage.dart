import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/ui/InputPage.dart';
import 'package:notes/utils/database_helper.dart';

class ListViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListViewPageState();
  }
}

class _ListViewPageState extends State<ListViewPage> {
  void editNote(BuildContext context, int index) async {
    Map<String, dynamic> result =
        await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new InputPage("edit", new Note.fromMap(list_of_notes[index]));
    }));
    if (result != null &&
        result["title"] != null &&
        result["title"].length > 0) {
      var db = new DatabaseHelper();
      int res = await db.updateNote(
          new Note(
            result["title"],
            (result["content"] == null ? "" : result["content"]),
            new DateTime.fromMillisecondsSinceEpoch(
                list_of_notes[index]["date_created"]),
            result["color"] == null
                ? list_of_notes[index]["color"]
                : result["color"],
          ),
          list_of_notes[index]["id"]);
      var snackbar = new SnackBar(content: new Text("Updated"));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  var database = new DatabaseHelper();
  List list_of_notes = [];

  @override
  Widget build(BuildContext context) {
    getNotes();
    return Container(
      decoration: new BoxDecoration(
        color: Colors.blueGrey.shade400,
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: new ListView.builder(
            itemCount: list_of_notes.length,
            itemBuilder: (_, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                  color: Color(int.parse(list_of_notes[index]["color"], radix: 16)),
                  child: new ListTile(
                    onTap: () {
                      editNote(context, index);
                    },
                    title: new Text((list_of_notes[index])["title"]),
                    subtitle: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          (list_of_notes[index])["content"],
                          textAlign: TextAlign.left,
                        ),
                        new Text(new DateFormat.yMEd().add_jms().format(
                            new DateTime.fromMillisecondsSinceEpoch(
                                list_of_notes[index]["date_created"]))),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void getNotes() async {
    var temp = await database.getAllNotes();
    setState(() {
      list_of_notes = temp;
    });
  }
}
