/*
A cascade component to pick item
 */

import 'package:flutter/material.dart';

class Cascade extends StatefulWidget {
  final List<dynamic> args;
  final onSelected;

  Cascade({Key key, this.args, this.onSelected}) : super(key: key);

  _CascadeState createState() =>
      _CascadeState(args: args, onSelected: onSelected);
}

class _CascadeState extends State<Cascade> {
  final List<dynamic> args;
  List<Widget> listView = <Widget>[];
  final onSelected;

  _CascadeState({this.args, this.onSelected});

  @override
  void initState() {
    super.initState();
    initView(this.args);
  }

  void initView(listData) {
    var newList = <Widget>[];
    for (var item in listData) {
      Widget tempWidget = GestureDetector(
        child: Container(
          child: Text(item?.name),
          color: Colors.white30,
          height: 30,
        ),
        onTap: () {
          widget.onSelected(item);
        },
      );
      newList.add(tempWidget);

      setState(() {
        listView = newList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: listView,
    ));
  }
}
