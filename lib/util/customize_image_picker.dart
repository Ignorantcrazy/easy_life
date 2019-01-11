import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'aspect_ratio_video.dart';
import 'package:easy_life/models/models.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/util/util.dart';
import 'package:easy_life/constant/constant.dart';

class CustomizeImagePicker extends StatefulWidget {
  final Models model;

  CustomizeImagePicker({Key key, this.model}) : super(key: key);
  @override
  _CustomizeImagePickerState createState() => _CustomizeImagePickerState();
}

class _CustomizeImagePickerState extends State<CustomizeImagePicker> {
  File uploadFile;
  Future<File> _imageFile;
  bool _isVideo = false;
  VideoPlayerController _controller;
  VoidCallback _listener;
  bool _isLoading = false;

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(_listener);
      }
      if (_isVideo) {
        ImagePicker.pickVideo(source: source).then((File file) {
          if (file != null && mounted) {
            uploadFile = file;
            setState(() {
              _controller = VideoPlayerController.file(file)
                ..addListener(_listener)
                ..setVolume(1.0)
                ..initialize()
                ..setLooping(true)
                ..play();
            });
          }
        });
      } else {
        _imageFile = ImagePicker.pickImage(source: source);
      }
    });
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

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
  }

  Widget _previewVideo(VideoPlayerController controller) {
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          uploadFile = snapshot.data;
          return Image.file(snapshot.data);
        } else if (snapshot.error != null) {
          return const Text(
            'Error picking image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'you have not yet picked an image',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  void _uploadHandle(File file) {
    if (file == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    Dio dio = new Dio();
    FormData formData = FormData.from({
      'file': UploadFileInfo(file, getfileNameByPath(file.path)),
    });
    dio
        .post(widget.model.apiBaseUrl + memoriesUploadUrl, data: formData)
        .then((v) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((err) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  List<Widget> _buildStack(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('image picker'),
      ),
      body: Center(
        child: _isVideo ? _previewVideo(_controller) : _previewImage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _isVideo = false;
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _isVideo = false;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                _uploadHandle(uploadFile);
              },
              heroTag: 'upload',
              tooltip: 'upload clond',
              child: const Icon(Icons.cloud_upload),
            ),
          ),
        ],
      ),
    );

    var widgets = List<Widget>();
    widgets.add(scaffold);
    if (_isLoading) {
      var modal = Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
      widgets.add(modal);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: _buildStack(context),
    );
  }
}
