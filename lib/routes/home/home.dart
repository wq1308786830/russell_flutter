import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/article/article_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/components/category_cascade.dart';
import 'package:russell_flutter/routes/articles/article_list.dart';
import 'package:russell_flutter/routes/home/drawer_widget.dart';

class Home extends StatelessWidget {

  final CategoryBloc _categoryBloc = CategoryBloc();

  Home() {
    // 派发事件开始获取分类数据
    _categoryBloc.dispatch(FetchCategory());
  }

  void onCategoryChange(value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: BlocProvider(
            builder: (BuildContext context) => _categoryBloc,
            child: DrawerWidget(),
          ),
        ),
        appBar: AppBar(
          title: Text('Russell'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            CategoryCascade(onCategoryChange: this.onCategoryChange),
            Flexible(
              child: BlocProvider(
                builder: (context) => ArticleBloc()..dispatch(FetchArticle()),
                child: ArticleList(),
              ),
            )
          ],
        )));
  }
}
