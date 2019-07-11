import 'package:equatable/equatable.dart';
import 'package:russell_flutter/models/article_shortend.dart';

abstract class ArticleState extends Equatable {
  ArticleState([List props = const []]) : super(props);
}

class ArticleUninitialized extends ArticleState {
  @override
  String toString() => 'Article Uninitialized';
}

class ArticleError extends ArticleState {
  @override
  String toString() => 'ArticleError';
}

class ArticleLoaded extends ArticleState {
  final List<ArticleShortened> articles;
  final bool hasReachedMax;

  ArticleLoaded({this.articles, this.hasReachedMax})
      : super([articles, hasReachedMax]);

  ArticleLoaded copyWith({
    List<ArticleShortened> articles,
    bool hasReachedMax
  }) {
    return ArticleLoaded(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  String toString() {
    return 'Article Loaded { posts: ${articles.length}, hasReachedMax: $hasReachedMax }';
  }
}
