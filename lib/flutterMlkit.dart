import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(FacePageState());
}

class FacePageState extends StatelessWidget {
  File imageFile;
  List<Face> faces;
  // var imageFromCamera = null;
  //to access the camera
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("WTF"),
      ),
    );
  }

  // ignore: unused_element
// ignore: slash_for_doc_comments
/**   void getImageAndDetecFaces() async {
    // ignore: unused_local_variable
    imageFromCamera = await _picker.getImage(source: ImageSource.camera);
  }*/
  void getImageAndDetectFaces() async {
    final imageFromCamera = await picker.getImage(source: ImageSource.camera);
  }
  // print(imageForCamera.toString())
  //print(imagefromCamera.runtimeType);
//  var selected = Image.file(File(imageFromCamera));
  //final selected = Image.file(File(imageFromCamera));
  //File select = File(imageFromCamera.);
  //final image = FirebaseVisionImage.fromFile(select);
}
