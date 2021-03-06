import 'package:flutter/material.dart';

Future<void> CustomDialog(String message, BuildContext bc) async {
  return showDialog<void>(
    context: bc,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('tip'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String getfileNameByPath(String filepath) {
  return filepath.substring(filepath.lastIndexOf('/') + 1);
}
