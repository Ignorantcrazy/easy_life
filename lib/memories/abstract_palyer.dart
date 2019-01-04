import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef Widget VideoWidgetBuilder(BuildContext context,VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget{
  final VideoWidgetBuilder childBuilder;
  final String dataSource;

  PlayerLifeCycle(this.dataSource,this.childBuilder);
}

abstract class PalyerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      controller = createVideoPlayerController();
      controller.addListener((){
        if (controller.value.hasError) {
          print(controller.value.errorDescription);
        }
      });
      controller.initialize();
      controller.setLooping(true);
      controller.play();
    }

    @override
    void deactivate(){
      super.deactivate();
    }

    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return widget.childBuilder(context,controller);
      }

    VideoPlayerController createVideoPlayerController();
}