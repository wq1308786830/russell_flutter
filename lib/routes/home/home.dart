import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:russell_flutter/blocs/article/article_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/components/category_cascade.dart';
import 'package:russell_flutter/routes/home/components/drawer_widget.dart';

import 'components/articles/article_list.dart';

class Home extends StatelessWidget {

  void onCategoryChange(value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    final ArticleBloc _articleBloc = BlocProvider.of<ArticleBloc>(context);
    final CategoryBloc _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _articleBloc.dispatch(FetchArticle());
    _categoryBloc.dispatch(FetchCategory());
    return Scaffold(
        drawer: Drawer(
          child: BlocProvider(
            builder: (BuildContext context) => _categoryBloc,
            child: DrawerWidget(),
          ),
        ),
        appBar: AppBar(
          title: SvgPicture.network(
            'https://v2.jinrishici.com/one.svg?${Random().nextDouble()}',
            color: Colors.white,
            placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              color: Colors.white,
              child: const CircularProgressIndicator()),
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            CategoryCascade(onCategoryChange: this.onCategoryChange),
            Flexible(
              child: BlocProvider(
                builder: (context) => _articleBloc,
                child: ArticleList(),
              ),
            )
          ],
        )));
  }
}
