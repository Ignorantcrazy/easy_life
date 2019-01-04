import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:path_provider/path_provider.dart';
import 'local_player.dart';
import 'package:video_player/video_player.dart';
import 'aspect_ratio_video.dart';

class LocalBody extends StatefulWidget {
  LocalBody({Key key}) : super(key: key);

  @override
  _LocalBodyState createState() => _LocalBodyState();
}

class _LocalBodyState extends State<LocalBody> {
  int handleType;
  List<LocalModel> localModelList;
  LocalModel localModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((v) {
      var dir = v.list();
      dir.forEach((f) {
        if (f is File) {
          String _fileType =
              f.path.substring(f.path.indexOf('.') + 1).toUpperCase();
          if (_fileType == "MP4") {
            localModelList.add(new LocalModel(f.path, false));
          }
          if (_fileType == "jpg") {
            localModelList.add(new LocalModel(f.path, true));
          }
        }
      });
      if (localModelList == null) {
        handleType = 0;
      } else {
        Random r = new Random();
        int i = r.nextInt(localModelList.length - 1);
        localModel = localModelList[i];
        setState(() {
          if (localModel.isImage) {
            handleType = 1;
          } else {
            handleType = 2;
          }
        });
      }
    }).catchError((err) {
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
          child: Text('can not find memones'),
        );
      case 1:
        return Image.network(localModel.dataSource);
      case 2:
        return LocalPlayerLifeCycle(
            localModel.dataSource,
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatioVideo(controller));
    }
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.red),
      child: Text('can not load'),
    );
  }
}
