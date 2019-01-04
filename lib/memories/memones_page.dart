import 'package:flutter/material.dart';
import 'online_body.dart';
import 'local_body.dart';

class MemonesPage extends StatefulWidget {
  MemonesPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: TabBar(
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.network_check),
                ),
                Tab(
                  icon: Icon(Icons.local_activity),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildOnlineBody(),
            _buildLocalBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineBody() {
    return OnlineBody();
  }

  Widget _buildLocalBody() {
    return LocalBody();
  }
}