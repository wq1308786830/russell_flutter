import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:russell_flutter/blocs/blocs.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _popContext() {
      Navigator.pop(context);
      return Future.value(false);
    }

    ArticleDetailBloc _detail = BlocProvider.of<ArticleDetailBloc>(context);
    _detail.dispatch(FetchArticleDetail());
    return WillPopScope(
      onWillPop: _popContext,
      child: Scaffold(
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
        body: Center(
          child: BlocBuilder(
            bloc: _detail,
            builder: (BuildContext ctx, ArticleDetailState state) {
              if (state is ArticleDetailError) {
                return Center(child: Text('failed to fetch article'));
              }
              if (state is ArticleDetailUninitialized) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ArticleDetailLoaded) {
                if (state.poetry == null) {
                  return Center(child: Text('no article'));
                }
                return Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsetsDirectional.only(top: 80.0, bottom: 40.0),
                      child: Text(
                        state.poetry.origin.title,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(bottom: 10.0),
                      child: Text(
                        state.poetry.origin.dynasty,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(bottom: 30.0),
                      child: Text(
                        state.poetry.origin.author,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Flexible(
                        child: ListView.builder(
                      itemCount: state.poetry.origin.content.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Center(
                          child: Text(
                            state.poetry.origin.content[index],
                            style: TextStyle(fontSize: 16, letterSpacing: 2, height: 2),
                          ),
                        );
                      },
                    )),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
