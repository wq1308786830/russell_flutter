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
        if (currentState is ArticleDetailLoaded) {
          yield ArticleDetailUninitialized();
        }
        if (currentState is ArticleDetailUninitialized) {
          final poetry = await _fetchPoetry();
          yield ArticleDetailLoaded(poetry: poetry);
          return;
        }
      } catch (err) {
        yield ArticleDetailError(errorMsg: err);
      }
    }
  }

  Future<Poetry> _fetchPoetry() async {
    final tokenResp = await httpClient.get('https://v2.jinrishici.com/token');
    final data = json.decode(tokenResp.body);
    final token = data['data'];

    final response = await httpClient.get('https://v2.jinrishici.com/sentence', headers: {"X-User-Token": token});
    if (response.statusCode == 200) {
      return parsePoetry(response.body);
    } else {
      throw Exception('error fetching articles');
    }
  }

  Poetry parsePoetry(String responseBody) {
    final parsed = json.decode(responseBody);
    final parsedData = parsed['data'] as Map<String, dynamic>;
    return Poetry.fromJson(parsedData);
  }
}
