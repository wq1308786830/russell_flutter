import 'package:equatable/equatable.dart';
import 'package:russell_flutter/models/poetry.dart';

abstract class ArticleDetailState extends Equatable {
  ArticleDetailState([List props = const []]) : super(props);
}

class ArticleDetailUninitialized extends ArticleDetailState {
  @override
  String toString() => 'ArticleDetail Uninitialized';
}

class ArticleDetailError extends ArticleDetailState {

  final errorMsg;
  ArticleDetailError({this.errorMsg});
  @override
  String toString() => 'ArticleDetailError: ${this.errorMsg}';
}

class ArticleDetailLoaded extends ArticleDetailState {
  final Poetry poetry;

  ArticleDetailLoaded({this.poetry}) : super([poetry]);

  ArticleDetailLoaded copyWith({ArticleDetailLoaded poetry}) {
    return ArticleDetailLoaded(poetry: poetry ?? this.poetry);
  }

  @override
  String toString() {
    return 'Poetry Loaded { posts: ${poetry.id} }';
  }
}
