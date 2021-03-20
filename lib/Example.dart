
//Global variable for storing the lost of camera avaailable
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
// Global variable for storing the list of
// cameras available
CameraDescription Camera;
class  Example extends StatelessWidget{
    CameraDescription camera;
   Example (CameraDescription cameraDescription){
    this.camera = cameraDescription;
    Camera = this.camera;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CameraScreen();
  }
  
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
