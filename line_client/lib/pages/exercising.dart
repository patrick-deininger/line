import 'package:flutter/material.dart';
import 'package:line_client/components/exercise_overlay.dart';
import 'package:video_player/video_player.dart';

class ExercisingPage extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<ExercisingPage> {
  VideoPlayerController _controller =
      VideoPlayerController.asset('assets/videos/out.mp4');

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/out.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          ExerciseOverlay()
        ]),
      ),
      //MaterialApp(home: Scaffold(body: Center(child: ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
