import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class FetchArticle extends ArticleEvent {

  @override
  String toString() => 'Fetch';
}