import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

Future<List<Category>> fetchList() async {
  final resp = await http
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
    return 'fatherId: $fatherId, id: $id, level: $level, name: $name, category';
  }
}
