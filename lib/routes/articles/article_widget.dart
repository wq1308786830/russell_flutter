import 'dart:math';

import 'package:flutter/material.dart';
import 'package:russell_flutter/models/article_shortend.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleShortened article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ran = Random();
    double colorH = ran.nextInt(360) * 1.0;
    double colorS = 1.0;
    double colorL = .5;
    double oppositeH = colorH > 180 ? colorH - 180.0 : 360.0 + (colorH - 180.0);
    var backColor = HSLColor.fromAHSL(1, colorH, colorS, colorL).toColor();
    var textColor = HSLColor.fromAHSL(1, oppositeH, colorS, colorL).toColor();
    return ListTile(
      leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.all(const Radius.circular(20)),
          ),
          child: Text(
            '${article.id}',
            style: TextStyle(
              fontSize: 16.0,
              color: textColor
            ),
          )),
      title: Text(article.title),
      isThreeLine: true,
      subtitle: Text(article.description),
      dense: true,
    );
  }
}
