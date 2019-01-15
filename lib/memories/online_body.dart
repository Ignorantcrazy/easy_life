import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/constant/constant.dart';
import 'models.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_life/util/aspect_ratio_video.dart';
import 'package:easy_life/models/models.dart';

class OnlineBody extends StatefulWidget {
  final Models model;
  OnlineBody({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnlineBodyState();
  }
}

class _OnlineBodyState extends State<OnlineBody> {
  VideoPlayerController _controller;
  VoidCallback _listener;
  int handleType;
  OnlineModel model;
  Dio dio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dio = new Dio();
    dio
        .get(widget.model.apiBaseUrl + memories_next_url + 'first')
        .then(_onValue)
        .catchError(_onError);
    _listener = () {
      setState(() {});
    };
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(_listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onValue(Response v) {
    Map modelMap = jsonDecode(jsonEncode(v.data));
    model = OnlineModel.fromJson(modelMap);
    if (model.isImage) {
      setState(() {
        handleType = 2;
      });
    } else {
      handleType = 3;
      setState(() {
        if (_controller != null) {
          _controller.setVolume(0.0);
          _controller.removeListener(_listener);
        }
        _controller = VideoPlayerController.network(
            widget.model.resBaseUrl + model.dataSource)
          ..addListener(_listener)
          ..setVolume(1.0)
          ..initialize()
          ..setLooping(true)
          ..play();
      });
    }
  }

  void _onError(err) {
    setState(() {
      handleType = 1;
    });
  }

  Widget _buildImage() {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails dsd) {
        dio
            .get(widget.model.apiBaseUrl +
                memories_next_url +
                (model.skipNum + 1).toString())
            .then(_onValue)
            .catchError(_onError);
      },
      child: Image.network(widget.model.resBaseUrl + model.dataSource),
    );
  }

  Widget _buildVideo(VideoPlayerController controller) {
    if (controller.value.initialized) {
      return GestureDetector(
        onVerticalDragStart: (DragStartDetails dsd) {
          dio
              .get(widget.model.apiBaseUrl +
                  memories_next_url +
                  (model.skipNum + 1).toString())
              .then(_onValue)
              .catchError(_onError);
        },
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'loading……',
        textAlign: TextAlign.center,
      );
    }
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
        return _buildImage();
      case 3:
        return _buildVideo(_controller);
      default:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.red),
          child: Text('can not load'),
        );
    }
  }
}
