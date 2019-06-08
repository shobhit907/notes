import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  String message="Hello, This Notes app is developed by Shobhit.\nHope you liked it.\nDo give him your feedback about this app.";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("About",style: new TextStyle(color: Colors.white,),),
          backgroundColor: Colors.blue.shade200,
        ),
        body: new Container(
          color: Colors.blueGrey.shade400,
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new Align(
                  child: new Text("$message",textAlign: TextAlign.center,style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),),
                  alignment: Alignment.center,
                ),
              ),
              new Expanded(child: new Align(
                child: new Text("©Shobhit Gupta 2019",textAlign: TextAlign.center,style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),),
                alignment: Alignment.bottomCenter,
              ),)
            ],
          ),
        ),
      ),
    );
  }

}