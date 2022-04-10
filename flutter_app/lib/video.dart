import 'package:flutter/material.dart';
// This recipe depends on one Flutter plugin: video_player. First, add this dependency to your pubspec.yaml.
import 'package:video_player/video_player.dart';

// before adding a video you must add android and ios permissions
// _____________________________________________________________

class VideoPlay extends StatefulWidget {
  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  // VideoPlayerController class allows you to connect to different types of videos and control playback.
  late VideoPlayerController _controller;
  late Future<void> _videoPlayerInitializer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    // Initialize the controller and store the Future for later use.
    _videoPlayerInitializer = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('butterfly video'),
      ),
      body: FutureBuilder(
        future: _videoPlayerInitializer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
      ),
    );
  }
}
