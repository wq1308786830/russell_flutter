import 'package:equatable/equatable.dart';

class PoetryDetail {
  String title;
  String dynasty;
  String author;
  List<String> content;
  List<String> translate;

  PoetryDetail(
      {this.title, this.dynasty, this.author, this.content, this.translate});

  /// mapped json poetry detail content cast to PoetryDetail class
  /// [jsn] mapped json
  PoetryDetail.fromJson(Map<String, dynamic> jsn) {
    title = jsn['title'];
    dynasty = jsn['dynasty'];
    author = jsn['author'];

    final contentList = jsn['content'] as List<dynamic>;
    final translateList = jsn['translate'] as List<dynamic>;
    content = contentList.map((rawContent) => rawContent as String).toList();
    translate =
        translateList.map((rawTranslate) => rawTranslate as String).toList();
  }
}

class Poetry extends Equatable {
  int popularity;
  String id;
  String content;
  String cacheAt;
  String recommendedReason;
  PoetryDetail origin;
  List<String> matchTags;

  Poetry(
      {this.id,
      this.content,
      this.popularity,
      this.origin,
      this.matchTags,
      this.recommendedReason,
      this.cacheAt});

  /// mapped json poetry content cast to Poetry class
  /// [jsn] mapped json
  Poetry.fromJson(Map<String, dynamic> jsn) {
    id = jsn['id'];
    content = jsn['content'];
    popularity = jsn['popularity'];
    recommendedReason = jsn['recommendedReason'];
    cacheAt = jsn['cacheAt'];

    final matchTagsList = jsn['matchTags'] as List<dynamic>;
    if (jsn['matchTags'] != null) {
      matchTags =
          matchTagsList.map((rawMatchTag) => rawMatchTag as String).toList();
    }

    if (jsn['origin'] != null) {
      origin = PoetryDetail.fromJson(jsn['origin']);
    }
  }

  @override
  String toString() => 'Poetry { id: $id }';
}
