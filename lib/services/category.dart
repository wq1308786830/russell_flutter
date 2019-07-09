import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:russell_flutter/models/category.dart' as models;

Future<List<models.Category>> fetchList() async {
  final httpClient = http.Client();
  final resp = await httpClient
      .post('http://russellwq.club:8081/1.0/article/getAllCategories');
  if (resp.statusCode == 200) {
    return compute(parseCategories, resp.body);
  } else {
    throw Exception('请求类目失败！');
  }
}

List<models.Category> parseCategories(String responseBody) {
  final parsed = json.decode(responseBody);
  final parsedData = parsed['data'].cast<Map<String, dynamic>>();
  final listData = parsedData
      .map<models.Category>((json) => models.Category.fromJson(json))
      .toList();
  return listData;
}
