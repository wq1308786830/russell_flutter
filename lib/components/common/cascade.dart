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
  List<dynamic> args;
  Row cascadeView;
  Function onSelected;

  _CascadeState({this.args, this.onSelected});

  void initView(listData) {
    Row rowView;
    List<Widget> allWidgetsTemp = <Widget>[];

    /// 循环组织每一列
    for (var i = 0; i < listData.length; i++) {
      Container columnContainer;
      List<Widget> widgetsTemp = <Widget>[];

      /// 循环组织每一列中的每一行
      for (var j = 0, o = listData[i]; j < o.length; j++) {
        Widget tempWidget = GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(o[j]?.name),
          ),
          onTap: () {
            widget.onSelected(j, i, o[j]);
          },
        );

        widgetsTemp.add(tempWidget);
        columnContainer = Container(
          color: Colors.deepOrangeAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widgetsTemp,
          ),
        );
      }

      allWidgetsTemp.add(columnContainer);
      rowView = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: allWidgetsTemp,
      );
    }
    this.cascadeView = rowView;
  }

  @override
  Widget build(BuildContext context) {
    initView(this.args);

    return Container(child: this.cascadeView);
  }
}
