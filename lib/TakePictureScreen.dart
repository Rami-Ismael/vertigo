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
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController _controller;
  Future<void> _initializeControllerFuture;

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
      body:FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt_outlined),
    onPressed: () async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
    // Ensure that the camera is initialized.
    await _initializeControllerFuture;

    // Attempt to take a picture and get the file `image`
    // where it was saved.
    final image = await _controller.takePicture();

    // If the picture was taken, display it on a new screen.
    Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
    // Pass the automatically generated path to
    // the DisplayPictureScreen widget.
    imagePath: image?.path,
    ),
    ),
    );
    } catch (e) {
    // If an error occurs, log the error to the console.
    print(e);
    }
    },
    ));
  }
  
}
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
