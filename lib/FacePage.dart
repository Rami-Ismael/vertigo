import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FacePage extends StatefulWidget {
    final CameraDescription camera;
  const FacePage({
  Key key,
    @required this.camera,
   }) : super(key: key);
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
      //floatingActionButton: cameraFloatingActionButton(),
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
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  // var imageFromCamera = null;
  //to access the camera
  final picker = ImagePicker();
  /**
   * Selected an Image
   * Load image for processing
   * Perform Face Detection
   */
  @override
  void initState() {
    super.initState();
    // To display the current output from the camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
  void getImageAndDetectFaces() async {
    try {
        initState();
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;
      //PickedFile imageFromCamera;
     // final imageFromCamera = await picker.getImage(source: ImageSource.camera);
      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final imageFromCamera = await _controller.takePicture();
      //final image = await
      print("imageFromCamera");
      print(imageFromCamera.runtimeType);
      //convert a pckedFile object to File object
      File imageFile = File(imageFromCamera.path);
      print("imageFile");
      print(imageFile);
      //use the firebase
      final image = FirebaseVisionImage.fromFile(imageFile);
      print("image");
      print(image);
      final faceDetector = FirebaseVision.instance .faceDetector(FaceDetectorOptions(mode: FaceDetectorMode.accurate));
      final faces = await faceDetector.processImage(image);
      print("asdfsa");
      print(faces[0].boundingBox.right);
      if (mounted) {
        setState(() {
          _imageFile = imageFile;
          _faces = faces;
          print("asdfsa");
          print(faces[0].boundingBox.right);
        }
        );
      }
      ImagesAndFaces(imageFile: _imageFile, faces: _faces);
      _faces.forEach((element) {
        print(element.toString());
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Scaffold2.0"),
      ),
      body: FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              //initState();
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;
              //PickedFile imageFromCamera;
              // final imageFromCamera = await picker.getImage(source: ImageSource.camera);
              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final imageFromCamera = await _controller.takePicture();
              //final image = await
              print("imageFromCamera");
              print(imageFromCamera);
              print(imageFromCamera.runtimeType);
              //convert a pckedFile object to File object
              File imageFile = File(imageFromCamera.path);
              print("imageFile");
              print(imageFile);
              print(imageFile.runtimeType);
              print(imageFile.path);
              //use the firebase
              final image = FirebaseVisionImage.fromFilePath(imageFile.path);
              print("image fghdfghdh");
              print(image.toString());
              final faceDetector = FirebaseVision.instance
                  .faceDetector(FaceDetectorOptions(mode: FaceDetectorMode.accurate));
              print(faceDetector);
              final faces =  await faceDetector.processImage(image);
              print("faces Faces");
              print(faces[0].boundingBox.right);
              print(faces);
              if (mounted) {
                setState(() {
                  print("rami");
                  _imageFile = imageFile;
                  print("rami1");
                  print(faces);
                  _faces = faces;
                  print(_faces);
                }
                );
              }
              ImagesAndFaces(imageFile: _imageFile, faces: _faces);
            } catch (e) {
              print(e);
            }
          },
          child: Icon(Icons.camera_alt_rounded))
    );
  }
  
}
