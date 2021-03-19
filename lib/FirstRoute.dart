import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SecondRoute.dart';

class FirstRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text("First Route"),
        ),
        body: Center(
          child: OutlineButton.icon(
            icon: Icon(Icons.add),
            onPressed: (){
              // Navigate back to first route when tapped.
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute())
              );
            },
            label: Text("Open Route"),
          ),
        ),
      );
  }
}