import 'package:flutter/material.dart';
import 'fade_animation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPause extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayPause(this.controller);

  @override
  _VideoPlayPauseState createState() => _VideoPlayPauseState();
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  FadeAnimation imageFadeAnim = FadeAnimation(
    child: const Icon(Icons.play_arrow, size: 100.0),
  );
  VoidCallback listener;

  _VideoPlayPauseState() {
    listener = () {
      setState(() {});
    };
  }

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
    controller.setVolume(1.0);
    controller.play();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    controller.setVolume(0.0);
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(controller),
        onTap: () {
          if (!controller.value.initialized) {
            return;
          }
          if (controller.value.isPlaying) {
            imageFadeAnim = FadeAnimation(
              child: const Icon(Icons.pause, size: 100.0),
            );
            controller.pause();
          } else {
            imageFadeAnim = FadeAnimation(
              child: const Icon(Icons.play_arrow, size: 100.0),
            );
            controller.play();
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      ),
      Center(
        child: imageFadeAnim,
      ),
    ];
    return Stack(
      fit: StackFit.passthrough,
      children: children,
    );
  }
}
