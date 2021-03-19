import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'FacePageState.dart';
import 'dart:async';

import 'package:vertigo/FirstRoute.dart';
import 'FacePageState.dart';
import 'video.dart';

void main() {
  //print("rami");
 // print(FacePageState());
  /**runApp(MaterialApp(
      home:FirstRoute()));*/
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertigo Assistance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

 /** @override
  _MyHomePageState createState() => _MyHomePageState();*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              Spacer(),
              IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
            ],
        )
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

