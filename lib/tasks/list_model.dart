import 'package:flutter/material.dart';
import 'task.dart';
import 'task_row.dart';

class ListModel {
  ListModel(this.listkey, items) : this.items = new List.of(items);

  final GlobalKey<AnimatedListState> listkey;
  final List<Task> items;

  AnimatedListState get _animatedlist => listkey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedlist.insertItem(index, duration: Duration(milliseconds: 150));
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedlist.removeItem(
        index,
        (context, animation) => TaskRow(
              task: removedItem,
              animation: animation,
            ),
        duration:
            Duration(milliseconds: (150 + 150 * (index / lenght)).toInt()),
      );
    }
    return removedItem;
  }

  int get lenght => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}
