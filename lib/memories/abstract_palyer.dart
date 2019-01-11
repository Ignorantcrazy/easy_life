import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  final VideoWidgetBuilder childBuilder;
  final String dataSource;

  PlayerLifeCycle(this.dataSource, this.childBuilder);
}

abstract class PalyerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    setState(() {
      if (controller != null) {
        controller.initialize();
        controller.setLooping(true);
        controller.play();
      }
    });
    // TODO: implement build
    return widget.childBuilder(context, controller);
  }

  VideoPlayerController createVideoPlayerController();
}
