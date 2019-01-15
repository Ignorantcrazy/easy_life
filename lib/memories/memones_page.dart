import 'package:flutter/material.dart';
import 'online_body.dart';
import 'local_body.dart';
import 'package:easy_life/models/models.dart';
import 'customize_image_picker.dart';

class MemonesPage extends StatefulWidget {
  final Models model;
  MemonesPage({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MemonesPageState();
  }
}

class _MemonesPageState extends State<MemonesPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomizeImagePicker(
                model: widget.model,
              );
            }));
          },
        ),
        // appBar: AppBar(
        //   title: Align(
        //     alignment: Alignment.center,
        //     child: TabBar(
        //       isScrollable: true,
        //       tabs: <Widget>[
        //         Tab(
        //           icon: Icon(Icons.network_check),
        //         ),
        //         Tab(
        //           icon: Icon(Icons.list),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: TabBarView(
          children: <Widget>[
            // _buildLocalBody(),
            _buildOnlineBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: OnlineBody(
        model: widget.model,
      ),
    );
  }

  Widget _buildLocalBody() {
    return LocalBody();
  }
}
