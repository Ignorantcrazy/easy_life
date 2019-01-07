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
  }

  void _onValue(Response v) {
    Map modelMap = jsonDecode(jsonEncode(v.data));
    model = OnlineModel.fromJson(modelMap);
    if (model.isImage) {
      setState(() {
        handleType = 2;
      });
    } else {
      setState(() { 
        handleType = 3;
      });
    }
  }

  void _onError(err) {
    print(err);
    setState(() {
      handleType = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (handleType) {
      case 1:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.red),
          child: Text('check network connection'),
        );
      case 2:
        return Image.network(model.dataSource);
      case 3:
        return NetworkPlayerLifeCycle(
            'http://192.168.2.31:8001/' + model.dataSource,
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatioVideo(controller));
      default:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.red),
          child: Text('can not load'),
        );
    }
  }
}
