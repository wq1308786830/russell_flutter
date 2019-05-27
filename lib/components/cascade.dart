/*
A cascade component to pick item
 */

import 'package:flutter/material.dart';

import 'category_cascade.dart';

class Cascade extends StatefulWidget {
  final List<String> args;

  Cascade({this.args, Key key}) : super(key: key);

  _CascadeState createState() => _CascadeState(args: args);
}

String dropdownValue = '哲学';

class _CascadeState extends State<Cascade> {
  final List<String> args;

  _CascadeState({this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CategoryCascade()
    );
  }
}
