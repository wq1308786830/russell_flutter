import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class PoetryDetail {
  final String title;
  final String dynasty;
  final String author;
  final List<String> content;
  final List<String> translate;

  PoetryDetail(
      {this.title, this.dynasty, this.author, this.content, this.translate});
}

@immutable
class Poetry extends Equatable {
  final String id;
  final String content;
  final int popularity;
  final PoetryDetail origin;
  final List<String> matchTags;
  final String recommendedReason;
  final String cacheAt;

  Poetry(
      {this.id,
      this.content,
      this.popularity,
      this.origin,
      this.matchTags,
      this.recommendedReason,
      this.cacheAt})
      : super([
          id,
          content,
          popularity,
          origin,
          matchTags,
          recommendedReason,
          cacheAt
        ]);

  @override
  String toString() => 'Poetry { id: $id }';
}
