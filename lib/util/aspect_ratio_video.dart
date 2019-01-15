import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_play_pause.dart';

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;
  AspectRatioVideo(this.controller);

  @override
  _AspectRatioVideoState createState() => _AspectRatioVideoState();
}

class _AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if(initialized){
      final Size size = controller.value.size;
      return Center(
        child: new AspectRatio(
          aspectRatio: size.width > size.height && size.width < size.height * 2 ? size.height / size.width : size.width / size.height ,
          child: VideoPlayPause(controller),
        ),
      );
    }
    return Container();
  }
}
