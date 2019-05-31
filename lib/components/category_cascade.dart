import 'dart:async';

import 'package:flutter/material.dart';
import 'package:russell_flutter/components/common/cascade.dart';
import 'package:russell_flutter/services/category.dart' as service;

class CategoryCascade extends StatefulWidget {
  _CategoryCascadeState createState() => _CategoryCascadeState();
}

class _CategoryCascadeState extends State<CategoryCascade> {
  List<service.Category> unhandledData;
  List<List<service.Category>> options;

  bool _active = false;
  List<int> selectedValue = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  /// 初始化组件选择数据
  Future initData() async {
    var respData = await service.fetchList();

    setState(() {
      unhandledData = respData;
      options = [respData];
    });
  }

  /// 当Cascade组件点击选择项事记录选项并展示下一级数据提供选择
  /// [level]表示当前选中的是第几列
  /// [value]表示当前选中的数据
  onSelected(int index, int level, service.Category value) {
    var allOptions = options;

    if (value.subCategory == null || value.subCategory.length == 0) {
      /// 写入尾部数据
      selectedValue.add(value.id);
    } else if (selectedValue.length == level) {
      /// 选择层级
      selectedValue.add(value.id);
      allOptions.add(value.subCategory);
    } else if (selectedValue.length > level &&
        value.id != selectedValue[level]) {
      /// 重新选择已选层级
      allOptions.removeRange(level + 1, allOptions.length);
      selectedValue.removeRange(level, selectedValue.length);

      selectedValue.add(value.id);
      allOptions.add(value.subCategory);
    } else {}

    setState(() {
      _active = selectedValue.length != options.length;
      selectedValue = selectedValue;
      options = allOptions;
    });
    print(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _active
            ? Container(
                child: options != null
                    ? Cascade(
                        args: options,
                        onSelected: (index, level, value) =>
                            onSelected(index, level, value))
                    : Text('Pengding...'),
              )
            : Container(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _active = !_active;
                    });
                  },
                  child: Text('show'),
                ),
              ),
      ],
    );
  }
}
