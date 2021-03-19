import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FacePage extends StatefulWidget {


  //StatefulWidget createState() =>ImagesAndFaces(imageFile: _imageFile,faces: _faces,);


  @override
  State<StatefulWidget> createState() => _FacePageState();
}



/**
 * this will hold the faces
 */
class ImagesAndFaces extends StatelessWidget {
  ImagesAndFaces({this.imageFile, this.faces});

  final File imageFile;
  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            child: Container(
              child: Image.file(imageFile),)),
        Flexible(child: ListView(
          children: faces.map<Widget>((e) => FaceCoordinate(e)).toList(),
        ))
      ],
    );
  }


}

class ImageScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Scaffold"),
      ),
      body: Container(),
      floatingActionButton: cameraFloatingActionButton(),
    );
  }
}

class cameraFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          _FacePageState().getImageAndDetectFaces();
        },
        child: Icon(Icons.camera_alt_rounded));
  }
}

//https://developers.google.com/android/reference/com/google/mlkit/vision/face/Face
class FaceCoordinate extends StatelessWidget{
  FaceCoordinate(this.face);
  final Face face;

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;
    print((' (${pos.top}, ${pos.left}), (${pos.bottom}, ${pos.right})'));
    return ListTile(
      title: Text(
          (' (${pos.top}, ${pos.left}), (${pos.bottom}, ${pos.right})')
      ),
    );
  }
}
class _FacePageState extends State<FacePage>{
  File _imageFile;
  List<Face> _faces;

  // var imageFromCamera = null;
  //to access the camera
  final picker = ImagePicker();
  /**
   * Selected an Image
   * Load image for processing
   * Perform Face Detection
   */
  void getImageAndDetectFaces() async {
    //PickedFile imageFromCamera;
    final imageFromCamera = await picker.getImage(source: ImageSource.camera);
    print(imageFromCamera.runtimeType);
    //convert a pckedFile object to File object
    File imageFile = File(imageFromCamera.path);
    print("imageFile");
    print(imageFile);
    //use the firebase
    final image = FirebaseVisionImage.fromFile(imageFile);
    print("image");
    print(image);
    final faceDetector = FirebaseVision.instance
        .faceDetector(FaceDetectorOptions(mode: FaceDetectorMode.accurate));
    final faces = await faceDetector.processImage(image);
    if(mounted){
        setState(() {
        _imageFile = imageFile;
        _faces = faces;
        }
    );}
    ImagesAndFaces(imageFile: _imageFile,faces:_faces);
    _faces.forEach((element) {print(element.toString());});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ImageScaffold();
  }
  
}
