import 'package:flutter/material.dart';
import 'package:easy_life/chat/chat_page.dart' show ChatPage;
import 'package:easy_life/smart_appliances/smart_appliances_page.dart'
    show SmartAppliancesPage;
import 'package:easy_life/memories/memones_page.dart' show MemonesPage;
import 'package:easy_life/tasks/tasks_page.dart' show TasksPage;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  Widget _buildBody() {
    switch (_selectIndex) {
      case 0:
        return ChatPage();
      case 1:
        return MemonesPage();
      case 2:
        return SmartAppliancesPage();
      case 3:
        return TasksPage();
      default:
        return ChatPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            title: Text('chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.memory),
            //activeIcon: Icon(Icons.star),
            title: Text('Memones'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_off),
            activeIcon: Icon(Icons.cloud),
            title: Text('SmartAppliances'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            activeIcon: Icon(Icons.filter_tilt_shift),
            title: Text('Tasks'),
          ),
        ],
        currentIndex: _selectIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTap,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}
