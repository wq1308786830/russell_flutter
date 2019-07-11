import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:russell_flutter/models/poetry.dart';
import 'package:russell_flutter/blocs/blocs.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  http.Client httpClient;

  ArticleDetailBloc() {
    this.httpClient = http.Client();
  }

  @override
  ArticleDetailState get initialState => ArticleDetailUninitialized();

  @override
  Stream<ArticleDetailState> mapEventToState(ArticleDetailEvent event) async* {
    if (event is FetchArticleDetail) {
      try {
        if (currentState is ArticleDetailUninitialized) {
          final poetry = await _fetchPoetry();
          yield ArticleDetailLoaded(poetry: poetry);
          return;
        }
      } catch (_) {
        yield ArticleDetailError();
        throw Exception(_);
      }
    }
  }

  Future<Poetry> _fetchPoetry() async {
    final tokenResp = await httpClient.get('https://v2.jinrishici.com/token');
    final data = json.decode(tokenResp.body);
    final token = data['data'];

    final response = await httpClient.get('https://v2.jinrishici.com/sentence', headers: {"X-User-Token": token});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['data'] as Poetry;
      return result;
    } else {
      throw Exception('error fetching articles');
    }
  }
}
