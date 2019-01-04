import 'package:flutter/material.dart';
import 'home/home_page.dart' show HomePage;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Life',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
