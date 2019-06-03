import 'package:flutter/material.dart';
import 'package:russell_flutter/components/category_cascade.dart';

class Home extends StatelessWidget {

  void onCategoryChange(value) {
    print(value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              CategoryCascade(onCategoryChange: this.onCategoryChange),
              Text('body'),
            ],
          )
        ));
  }
}
