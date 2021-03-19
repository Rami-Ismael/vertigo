import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vertigo/TakePictureScreen.dart';
import 'FacePageState.dart';
import 'dart:async';

import 'package:vertigo/FirstRoute.dart';
import 'FacePageState.dart';
import 'video.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  print(firstCamera.runtimeType);
  //print("rami");
 // print(FacePageState());
  /**runApp(MaterialApp(
      home:FirstRoute()));*/
  runApp(MyApp(firstCamera));

}

class MyApp extends StatelessWidget {
  MyApp(this.cameraDescription);
  final CameraDescription cameraDescription;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertigo Assistance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',cameraDescription: cameraDescription,),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title,this.cameraDescription}) : super(key: key);
  final String title;
  final CameraDescription cameraDescription;

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
              IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {
                  //navigate to the second butotn
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TakePictureScreen(camera: cameraDescription)));
              }),
            ],
        )
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

