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
  String id;
  String content;
  int popularity;
  PoetryDetail origin;
  List<String> matchTags;
  String recommendedReason;
  String cacheAt;

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

  Poetry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    popularity = json['popularity'];
    matchTags = json['matchTags'];
    recommendedReason = json['recommendedReason'];
    cacheAt = json['cacheAt'];
    if (json['origin'] != null) {
      origin = PoetryDetail();
//      json['origin'].forEach((v) {
//        origin.add(PoetryDetail.fromJson(v));
//      });
    }
  }

  @override
  String toString() => 'Poetry { id: $id }';
}
