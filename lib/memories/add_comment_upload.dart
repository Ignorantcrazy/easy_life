import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddCommentUpload extends StatefulWidget {
  final CustomCallVoidFunc callback;
  AddCommentUpload({Key key, this.callback}) : super(key: key);

  @override
  _AddCommentUploadState createState() => _AddCommentUploadState();
}

class _AddCommentUploadState extends State<AddCommentUpload> {
  var _titleController = TextEditingController();
  var _tag = '';
  var _tags = <String>['lover', 'child', 'happy', 'sad'];
  var _remarkController = TextEditingController();
  var _showTime = DateFormat("yyyy-MM-dd").format(DateTime.now());
  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'input name',
                  labelText: 'name',
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.display1,
                validator: (v) {
                  return v.trim() == '' && v.indexOf('.') >= 0
                      ? 'enter ture name'
                      : null;
                },
              ),
              InkWell(
                child: InputDecorator(
                  decoration: InputDecoration(labelText: 'show time'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_showTime),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2014, 9),
                    lastDate: DateTime(2101),
                  ).then((v) {
                    setState(() {
                      _showTime = DateFormat('yyyy-MM-dd').format(v);
                    });
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'tag',
                  hintText: 'tag',
                ),
                value: _tag,
                items: _tags.map((f) {
                  return DropdownMenuItem(
                    value: f,
                    child: Text(f),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tag = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                autofocus: false,
                autovalidate: false,
                controller: _remarkController,
                decoration: InputDecoration(
                  labelText: 'say something',
                  hintText: 'Tell us about that memories',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Builder(
                        builder: (BuildContext context) {
                          return RaisedButton(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('save'),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if (Form.of(context).validate()) {
                                widget.callback(
                                    _titleController.text.trim(),
                                    _showTime,
                                    _tag,
                                    _remarkController.text.trim());
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

typedef CustomCallVoidFunc = void Function(String, String, String, String);
