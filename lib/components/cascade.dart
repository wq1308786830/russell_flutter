/*
A cascade component to pick item
 */

import 'package:flutter/material.dart';

class Cascade extends StatefulWidget {
  final List<dynamic> args;

  Cascade({Key key, this.args}) : super(key: key);

  _CascadeState createState() => _CascadeState(args: args);
}

class _CascadeState extends State<Cascade> {
  final List<dynamic> args;

  _CascadeState({this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: this.args.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Text(this.args != null ? this.args[index]?.name : ''),
          ),
        );
      },
    ));
  }
}
