import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:russell_flutter/models/poetry.dart';
import 'package:russell_flutter/blocs/blocs.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  http.Client httpClient;
  int startIndex, limit;

  ArticleBloc() {
    this.httpClient = http.Client();
    this.limit = 20;
    this.startIndex = 0;
  }

  @override
  ArticleState get initialState => ArticleDetailUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleDetail) {
      try {
        if (currentState is ArticleDetailUninitialized) {
          final articles = await _fetchPoetry();
          yield ArticleLoaded(articles: articles, hasReachedMax: false);
          return;
        }
      } catch (_) {}
    }
  }

  Future<Poetry> _fetchPoetry() async {
    final response = await httpClient.get('https://v2.jinrishici.com/sentence');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Poetry;
      return data;
    } else {
      throw Exception('error fetching articles');
    }
  }
}
