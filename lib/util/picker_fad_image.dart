import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerFadImage extends StatefulWidget {
  final ImageSource2VoidFunc pickerHandle;
  PickerFadImage({Key key, this.pickerHandle}) : super(key: key);

  @override
  _PickerFadImageState createState() => _PickerFadImageState();
}

class _PickerFadImageState extends State<PickerFadImage>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  AnimationController _controller;
  Animation<Color> _animationColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButtion;
  double _fabHeight = 56.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(microseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _animationColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButtion = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.75, curve: Curves.easeOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    if (!_isOpened) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isOpened = !_isOpened;
  }

  Widget _pickImageGallery() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          widget.pickerHandle(false, ImageSource.gallery);
        },
        tooltip: 'pick image from gallery',
        child: Icon(Icons.photo_library),
      ),
    );
  }

  Widget _pickImageCamera() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          widget.pickerHandle(false, ImageSource.camera);
        },
        tooltip: 'pick image from camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _pickVideoGallery() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          widget.pickerHandle(true, ImageSource.gallery);
        },
        tooltip: 'choose video from gallery',
        child: Icon(Icons.video_library),
      ),
    );
  }

  Widget _pickVideoCamera() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          widget.pickerHandle(true, ImageSource.camera);
        },
        tooltip: 'pick video from camera',
        child: Icon(Icons.videocam),
      ),
    );
  }

  Widget _toggle() {
    return FloatingActionButton(
      backgroundColor: _animationColor.value,
      onPressed: _animate,
      tooltip: 'toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: _animationIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtion.value * 4,
            0.0,
          ),
          child: _pickImageGallery(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtion.value * 3,
            0.0,
          ),
          child: _pickImageCamera(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtion.value * 2,
            0.0,
          ),
          child: _pickVideoGallery(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtion.value,
            0.0,
          ),
          child: _pickVideoCamera(),
        ),
        _toggle(),
      ],
    );
  }
}

typedef ImageSource2VoidFunc = void Function(bool, ImageSource);
