import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ArticleEvent extends Equatable {
  ArticleEvent([List props = const []]) : super(props);
}

class FetchArticle extends ArticleEvent {

  @override
  String toString() => 'Fetch';
}

class FetchClassifiedArticle extends ArticleEvent {

  final int categoryId;

  FetchClassifiedArticle({@required this.categoryId}) : super([categoryId]);

  @override
  String toString() => 'fetch classified article';
}
