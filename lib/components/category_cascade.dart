import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cascade.dart';

class CategoryCascade extends StatefulWidget {
  _CategoryCascadeState createState() => _CategoryCascadeState();
}

List<Category> list = fetchList();

class _CategoryCascadeState extends State<CategoryCascade> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Cascade(args: list),
    );
  }
}

Future<List<Category>> fetchList() async {
  final resp =
      await http.get('http://47.112.23.45:5001/1.0/article/getAllCategories');
  if (resp.statusCode == 200) {
    print(resp);
    return Category.fromJson(json.decode(resp.body));
  } else {
    throw Exception('Faild to load list');
  }
}

class Category {
  final int fatherId;
  final int id;
  final int level;
  final String name;

  Category({this.fatherId, this.id, this.level, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      fatherId: json['father_id'],
      id: json['id'],
      level: json['level'],
      name: json['name'],
    );
  }
}
