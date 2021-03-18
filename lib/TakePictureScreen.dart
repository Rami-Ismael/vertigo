import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget{

  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);
  @override
  @override
  TakePictureScreenState createState() => TakePictureScreenState ();

}

class TakePictureScreenState extends State<TakePictureScreen>  {
  //Camera Controller this process established a connection to the devices camera that
  CameraController controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Take a picture",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}