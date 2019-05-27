import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cascade.dart';

class CategoryCascade extends StatefulWidget {
  _CategoryCascadeState createState() => _CategoryCascadeState();
}

List<Category> list;

class _CategoryCascadeState extends State<CategoryCascade> {
  @override
  Widget build(BuildContext context) {
    getCategories();
    return Container(
      child: Text('ddd'),
    );
  }
}

Future<void> getCategories() async {
  try {
    List<Category> list = await fetchList();
    print(json.encode(list));
  } catch (e) {
    print(e);
  }
}

Future<List<Category>> fetchList() async {
  final resp =
      await http.post('http://47.112.23.45:5001/1.0/article/getAllCategories');
  if (resp.statusCode == 200) {
    print(resp);
    return parseCategories(resp.body);
  } else {
    throw Exception('Faild to load list');
  }
}

List<Category> parseCategories(String responseBody) {
  final parsed = json.decode(responseBody);
  final parsedData = parsed['data'].cast<Map<String, dynamic>>();
  return parsedData.map<Category>((json) => Category.fromJson(json)).toList();
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

  @override
  String toString() {
    return name;
  }
}
