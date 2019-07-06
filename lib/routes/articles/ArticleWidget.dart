import 'package:flutter/material.dart';
import 'package:russell_flutter/models/article_shortend.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleShortened article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${article.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(article.title),
      isThreeLine: true,
      subtitle: Text(article.description),
      dense: true,
    );
  }
}
