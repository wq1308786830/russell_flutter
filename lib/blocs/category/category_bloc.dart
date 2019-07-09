import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/models/category.dart' as model;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  ArticleBloc _articleBloc;
  http.Client httpClient;

  CategoryBloc() {
    _articleBloc = ArticleBloc();
    httpClient = http.Client();
  }

  @override
  CategoryState get initialState => CategoryUninitialized();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory) {
      try {
        if (currentState is CategoryUninitialized) {
          final categories = await _fetchCategories();
          yield CategoryLoaded(categories);
          return;
        }
      } catch (_) {
        yield CategoryError();
      }
    } else if (event is CategoryPressed) {
      _articleBloc
          .dispatch(FetchClassifiedArticle(categoryId: event.category.id));
    }
  }

  /// 获取类目数据
  Future<List<model.Category>> _fetchCategories() async {
    final response = await httpClient
        .post('http://russellwq.club:8081/1.0/article/getAllCategories');

    if (response.statusCode == 200) {
      var computed = parseCategories(response.body);
      return computed;
    } else {
      throw Exception('error fetching categories');
    }
  }

  List<model.Category> parseCategories(String responseBody) {
    final parsed = json.decode(responseBody);
    final parsedData = parsed['data'].cast<Map<String, dynamic>>();
    final listData = parsedData
        .map<model.Category>((json) => model.Category.fromJson(json))
        .toList();
    return listData;
  }
}
