import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:russell_flutter/blocs/blocs.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ArticleDetailBloc _detail = BlocProvider.of(context);
    _detail.dispatch(FetchArticleDetail());
    return Scaffold(
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
              return Container(
                child: Text(state.poetry.content),
              );
            }
          },
        ),
      ),
    );
  }
}
