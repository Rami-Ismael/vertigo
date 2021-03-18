
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FacePageState extends  StatefulWidget{
  File _imageFile;
  List<Face> _faces;
  // var imageFromCamera = null;
  //to access the camera
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: WTFScaffold());
  }

  /**
   * Selected an Image
   * Load image for processing
   * Perform Face Detection
   */
  void getImageAndDetectFaces() async {
    //PickedFile imageFromCamera;
    final imageFromCamera = await picker.getImage(source: ImageSource.camera);
    print(imageFromCamera.runtimeType);
    //convert a pIckedFile object to File object
    File imageFile  = File(imageFromCamera.path);
    //use the firebase
     final image = FirebaseVisionImage.fromFile(imageFile);
     final faceDetector = FirebaseVision.instance.faceDetector(
       FaceDetectorOptions(
         mode: FaceDetectorMode.accurate
       )
     );
    final faces = await faceDetector.processImage(image);
    setState(() {
    _imageFile = imageFile;
    _faces = faces;
    }
    );
    print(faces);
  }

  //StatefulWidget createState() =>ImagesAndFaces(imageFile: _imageFile,faces: _faces,);

  void setState(Null Function() param0) {}


// print(imageForCamera.toString())
//print(imagefromCamera.runtimeType);
//  var selected = Image.file(File(imageFromCamera));
//final selected = Image.file(File(imageFromCamera));
//File select = File(imageFromCamera.);
//final image = FirebaseVisionImage.fromFile(select);
}

class FacePage {
}
/**
 * this will hold the faces
 */
class ImagesAndFaces extends StatefulWidget {
  ImagesAndFaces({this.imageFile,this.faces});
  final File imageFile;
  final List<Face> faces;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(child: Container( child: Image.file(imageFile),))
      ],
    );
  }

}
class WTFScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("WTF"),
      ),
      floatingActionButton: cameraFloatingActionButton(),
    );
  }

}
class cameraFloatingActionButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return FloatingActionButton(onPressed: () async {FacePageState().getImageAndDetectFaces();},
      child: Icon(Icons.camera_alt_rounded));
  }

}
class fireVision extends StatefulWidget {
  //use firevision
  //final image = FirebaseVisionImage.fromFile(getImageAndDetectFaces())

  final faceDetector = FirebaseVision.instance.faceDetector(
    FaceDetectorOptions(
      mode:  FaceDetectorMode.accurate,
    )
  );
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}