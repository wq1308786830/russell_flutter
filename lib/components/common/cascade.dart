/*
A cascade component to pick item
 */

import 'package:flutter/material.dart';

class Cascade extends StatefulWidget {
  final List<dynamic> args;
  final onSelected;

  Cascade({Key key, this.args, this.onSelected}) : super(key: key);

  _CascadeState createState() => _CascadeState(args: args, onSelected: onSelected);
}

class _CascadeState extends State<Cascade> {
  final List<dynamic> args;
  final onSelected;

  _CascadeState({this.args, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: this.args.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onSelected(this.args[index]);
          },
          child: Container(
            height: 30,
            color: Colors.white,
            child: Center(
              child: Text(this.args != null ? this.args[index]?.name : ''),
            ),
          ),
        );
      },
    ));
  }
}
