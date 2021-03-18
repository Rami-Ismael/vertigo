import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
       MaterialApp(
        title: "Video PLayer App",
        home: VideoPlayerScreen(),
      )
    ;
  }



}
class VideoPlayerScreen extends StatefulWidget{
  //store the video_player plugin installed with the correct permission
    VideoPlayerScreen({Key key}): super (key: key);
    @override
    _VideoPlayerScreenState  createState() => _VideoPlayerScreenState();

}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>  {
  VideoPlayerController _controller;
  //Add a variable to the State class to store the Future returned from VideoPlayerController.initialize
  Future<void> _initializeVideoPLayerFuture;

  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPLayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
    );
  }
}
