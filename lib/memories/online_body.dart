import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/constant/constant.dart';
import 'models.dart';
import 'network_player.dart';
import 'package:video_player/video_player.dart';
import 'aspect_ratio_video.dart';

class OnlineBody extends StatefulWidget {
  OnlineBody({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnlineBodyState();
  }
}

class _OnlineBodyState extends State<OnlineBody> {
  int handleType;
  OnlineModel model;
  Dio dio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dio = new Dio();
    dio.get(baseHttpPath + resHttpPath).then(_onValue).catchError(_onError);
    setState(() {});
  }

  void _onValue(v) {
    Map modelMap = jsonDecode(v.toString());
    model = OnlineModel.fromJson(modelMap);
    if (model.isImage) {
      setState(() {
        handleType = 1;
      });
    } else {
      setState(() {
        handleType = 2;
      });
    }
  }

  void _onError(err) {
    setState(() {
      handleType = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (handleType) {
      case 0:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.red),
          child: Text('check network connection'),
        );
      case 1:
        return Image.network(model.dataSource);
      case 2:
        return NetworkPlayerLifeCycle(
            model.dataSource,
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatioVideo(controller));
    }
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.red),
      child: Text('can not load'),
    );
  }
}
