import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/models/article_shortend.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleShortened article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticleDetailBloc _detailBloc = BlocProvider.of<ArticleDetailBloc>(context);
    var ran = Random();
    double colorH = ran.nextInt(360) * 1.0;
    double colorS = 1.0;
    double colorL = .5;
    // 补色色相计算
    double oppositeH = colorH > 180 ? colorH - 180.0 : 360.0 + (colorH - 180.0);
    // 背景色
    var backColor = HSLColor.fromAHSL(1, colorH, colorS, colorL).toColor();
    // 背景上的文本色
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
            '${this.article.id}',
            style: TextStyle(
              fontSize: 16.0,
              color: textColor
            ),
          )),
      title: Text(this.article.title),
      isThreeLine: true,
      subtitle: Text(this.article.description),
      dense: true,
      onTap: () {
        Navigator.pushNamed(context, '/articleDetail');
      },
    );
  }
}
