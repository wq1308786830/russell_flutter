import 'package:flutter/material.dart';
import 'package:russell_flutter/components/category_cascade.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: CategoryCascade());
  }
}
