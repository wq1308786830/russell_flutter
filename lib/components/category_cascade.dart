import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:russell_flutter/components/common/cascade.dart';

class CategoryCascade extends StatefulWidget {
  _CategoryCascadeState createState() => _CategoryCascadeState();
}

class _CategoryCascadeState extends State<CategoryCascade> {
  bool _active = false;
  Level showLevel = Level.level1;
  List<int> selectedValue = [];

  onSelected(value) {
    if (selectedValue.length == 0 ||
        value.id == selectedValue[selectedValue.length - 1]) {
      selectedValue.add(value.id);
    }

    setState(() {
      _active = false;
      selectedValue = selectedValue;
    });
    print(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _active
            ? Container(
                width: 200,
                height: 200,
                child: FutureBuilder<List<Category>>(
                  future: fetchList(http.Client()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Cascade(
                            args: snapshot.data,
                            onSelected: (value) => onSelected(value))
                        : Text('Pengding...');
                  },
                ),
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

Future<List<Category>> fetchList(http.Client client) async {
  final resp = await client
      .post('http://russellwq.club:8081/1.0/article/getAllCategories');
  if (resp.statusCode == 200) {
    var computed = compute(parseCategories, resp.body);
    return computed;
  } else {
    throw Exception('请求类目失败！');
  }
}

List<Category> parseCategories(String responseBody) {
  final parsed = json.decode(responseBody);
  final parsedData = parsed['data'].cast<Map<String, dynamic>>();
  final listData =
      parsedData.map<Category>((json) => Category.fromJson(json)).toList();
  return listData;
}

class Category {
  int fatherId;
  int id;
  int level;
  String name;
  List<Category> subCategory;

  Category({this.fatherId, this.id, this.level, this.name, this.subCategory});

  Category.fromJson(Map<String, dynamic> json) {
    fatherId = json['father_id'];
    id = json['id'];
    level = json['level'];
    name = json['name'];
    if (json['subCategory'] != null) {
      subCategory = List<Category>();
      json['subCategory'].forEach((v) {
        subCategory.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['father_id'] = this.fatherId;
    data['id'] = this.id;
    data['level'] = this.level;
    data['name'] = this.name;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'fatherId: $fatherId, id: $id, level: $level, name: $name, category: $subCategory';
  }
}

enum Level { level1, level2, level3 }
