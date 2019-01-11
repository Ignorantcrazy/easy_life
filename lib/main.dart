import 'package:flutter/material.dart';
import 'home/home_page.dart' show HomePage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_life/models/models.dart';
import 'package:easy_life/settings/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSet = false;
  Models model;
  SharedPreferences spre;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then(_onValue).catchError(_onError);
  }

  void _onValue(SharedPreferences v) {
    spre = v;
    String _apiBaseUrl = v.getString('apiBaseUrl');
    String _resBaseUrl = v.getString('resBaseUrl');
    if (_apiBaseUrl == null || _resBaseUrl == null) {
      setState(() {
        isSet = false;
      });
    } else {
      model = Models(_apiBaseUrl, _resBaseUrl);
      setState(() {
        isSet = true;
      });
    }
  }

  void _onError(err) {}

  void _clearCache() {
    spre.clear();
    setState(() {
      isSet = false;
    });
  }

  void _modelHandle(apiBaseUrl, resBaseUrl) {
    this.model = Models(apiBaseUrl, resBaseUrl);
    spre.setString('apiBaseUrl', model.apiBaseUrl);
    spre.setString('resBaseUrl', model.resBaseUrl);
    setState(() {
      isSet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Life',
      theme: ThemeData.dark(),
      home: isSet
          ? HomePage(
              model: model,
              clearCache: _clearCache,
            )
          : SettingsPage(
              modelHandle: _modelHandle,
            ),
    );
  }
}
