import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ArticleShortened extends Equatable {
  final int id;
  final String title;
  final String description;
  final String avatar;
  final String clickCount;
  final int isRecommend;
  final DateTime datePublish;
  final int categoryId;
  final int userId;

  ArticleShortened(
      {this.id,
      this.title,
      this.description,
      this.avatar,
      this.clickCount,
      this.isRecommend,
      this.datePublish,
      this.categoryId,
      this.userId})
      : super([
          id,
          title,
          description,
          avatar,
          clickCount,
          isRecommend,
          datePublish,
          categoryId,
          userId
        ]);

  @override
  String toString() => 'ArticleShortened { id: $id }';
}
