import 'package:flutter/material.dart';

class FancyFab extends StatefulWidget {
  final VoidCallback chooseImageHandle;
  final VoidCallback chooseCameraHandle;
  final String tooltip;
  final IconData icon;
  FancyFab({Key key, this.chooseImageHandle,this.chooseCameraHandle, this.tooltip, this.icon})
      : super(key: key);

  @override
  _FacyFabState createState() => _FacyFabState();
}

class _FacyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButtion;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButtion = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget _chooseCamera(){
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'choose camera',
        child: Icon(Icons.camera),
      ),
    );
  }

  Widget _chooseImage(){
    return Container(
      child: FloatingActionButton(
        onPressed: widget.chooseImageHandle,
        tooltip: 'choose image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget _toggle() {
    return FloatingActionButton(
      backgroundColor: _buttonColor.value,
      onPressed: _animate,
      tooltip: 'toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
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
            _translateButtion.value * 2,
            0.0,
          ),
          child: _chooseCamera(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButtion.value,
            0.0,
          ),
          child: _chooseImage(),
        ),
        _toggle(),
      ],
    );
  }
}
