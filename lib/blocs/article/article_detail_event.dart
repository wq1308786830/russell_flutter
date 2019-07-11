import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ArticleDetailEvent extends Equatable {
  ArticleDetailEvent([List props = const []]) : super(props);
}

class FetchArticleDetail extends ArticleDetailEvent {

  @override
  String toString() => 'FetchArticleDetail';
}
