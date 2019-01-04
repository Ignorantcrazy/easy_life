import 'package:flutter/material.dart';
import 'dialogonal_clipper.dart';
import 'task.dart';
import 'task_row.dart';
import 'list_model.dart';
import 'animated_fab.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final double _imageHeight = 256.0;
  List<Task> tasks = [
    new Task(
        name: "Catch up with Brian",
        category: "Mobile Project",
        time: "5pm",
        color: Colors.orange,
        completed: false),
    new Task(
        name: "Make new icons",
        category: "Web App",
        time: "3pm",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Design explorations",
        category: "Company Website",
        time: "2pm",
        color: Colors.pink,
        completed: false),
    new Task(
        name: "Lunch with Mary",
        category: "Grill House",
        time: "12pm",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Teem Meeting",
        category: "Hangouts",
        time: "10am",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "have a rest",
        category: "my house",
        time: "09am",
        color: Colors.green,
        completed: true),
  ];

  final GlobalKey<AnimatedListState> _listkey =
      new GlobalKey<AnimatedListState>();
  ListModel listmodel;
  bool showOnlyCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listmodel = new ListModel(_listkey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildTimeLine(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Positioned(
      top: _imageHeight - 100.0,
      right: -40.0,
      child: AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listmodel.removeAt(listmodel.indexOf(task));
      } else {
        listmodel.insert(tasks.indexOf(task), task);
      }
    });
  }

  Widget _buildTimeLine() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Padding(
      padding: EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTaskHeader(),
          _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: _listkey,
        itemBuilder: (context, index, animation) {
          return TaskRow(
            task: listmodel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildTaskHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'My Tasks',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'FEBRUARY 8, 2015',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipPath(
      clipper: DialogonalClipper(),
      child: Image.asset(
        'assets/images/taskbg.jpg',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, size: 32.0, color: Colors.white),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Tasks",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Icon(
            Icons.linear_scale,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: AssetImage('assets/images/favicon.ico'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'l',
                  style: new TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'w',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
