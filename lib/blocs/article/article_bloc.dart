import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:russell_flutter/models/article_shortend.dart';
import 'package:rxdart/rxdart.dart';
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
  ArticleState get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticle && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleUninitialized) {
          final articles = await _fetchArticles(this.startIndex, this.limit);
          yield ArticleLoaded(articles: articles, hasReachedMax: false);
          return;
        }
        if (currentState is ArticleLoaded) {
          final articles = await _fetchArticles(
              (currentState as ArticleLoaded).articles.length + this.startIndex, this.limit);
          yield articles.isEmpty
              ? (currentState as ArticleLoaded).copyWith(hasReachedMax: true)
              : ArticleLoaded(
                  articles: (currentState as ArticleLoaded).articles + articles,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield ArticleError();
      }
    } else if (event is FetchClassifiedArticle &&
        !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleLoaded) {
          yield ArticleUninitialized();
        }
        if (currentState is ArticleUninitialized) {
          this.startIndex = 20;
          this.limit = 10;
          final articles = await _fetchArticles(this.startIndex, this.limit);
          yield ArticleLoaded(articles: articles, hasReachedMax: false);
          return;
        }
      } catch (_) {
        yield ArticleError();
      }
    }

    if (event is FetchArticleDetail) {
      try {
        if (currentState is ArticleDetailUninitialized) {

        }
      }
    }
  }

  bool _hasReachedMax(ArticleState state) =>
      state is ArticleLoaded && state.hasReachedMax;

  Future<List<ArticleShortened>> _fetchArticles(
      int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawArticle) {
        return ArticleShortened(
            id: rawArticle['id'],
            title: rawArticle['title'],
            description: rawArticle['body']);
      }).toList();
    } else {
      throw Exception('error fetching articles');
    }
  }

  @override
  Stream<ArticleState> transform(Stream<ArticleEvent> events,
      Stream<ArticleState> Function(ArticleEvent event) next) {
    return super.transform(
        (events as Observable<ArticleEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }
}
