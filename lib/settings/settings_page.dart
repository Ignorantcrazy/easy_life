import 'package:flutter/material.dart';
import 'package:easy_life/models/models.dart';

class SettingsPage extends StatelessWidget {
  final Strings2VoidFunc modelHandle;
  SettingsPage({Key key, this.modelHandle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _apiController = TextEditingController();
    _apiController.text = 'http://192.168.2.31:5000';
    TextEditingController _resController = TextEditingController();
    _resController.text = 'http://192.168.2.31:8001';
    GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

    void _saveHanlde(){
      this.modelHandle(_apiController.text.trim(),_resController.text.trim());
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
        child: Form(
          key: _fromKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _apiController,
                decoration: InputDecoration(
                  labelText: 'api',
                  hintText: 'api base url'
                ),
                validator: (v){
                  var _api = v.trim();
                  if (_api.length < 14 || !_api.toUpperCase().contains('HTTP')
                  || _api.split('.').length < 4) {
                    return 'enter the correct api url';
                  }
                },
              ),
              TextFormField(
                autofocus: false,
                controller: _resController,
                decoration: InputDecoration(
                  labelText: 'res',
                  hintText: 'res base url'
                ),
                validator: (v){
                  var _api = v.trim();
                  if (_api.length < 14 || !_api.toUpperCase().contains('HTTP')
                  || _api.split('.').length < 4) {
                    return 'enter the correct  res url';
                  }
                },
              ),
              Padding(
                padding:const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Builder(builder: (context){
                        return RaisedButton(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('save'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: (){
                            if (Form.of(context).validate()) {
                              _saveHanlde();
                            }
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
