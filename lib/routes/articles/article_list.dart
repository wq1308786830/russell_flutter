import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/article/article_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/components/common/bottom_loader.dart';
import 'package:russell_flutter/routes/articles/article_widget.dart';

class ArticleList extends StatefulWidget {
  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _articleBloc,
      builder: (BuildContext context, ArticleState state) {
        if (state is ArticleError) {
          return Center(child: Text('failed to fetch articles'));
        }
        if (state is ArticleUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ArticleLoaded) {
          if (state.articles.isEmpty) {
            return Center(child: Text('no articles'));
          }
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.articles.length
                    ? BottomLoader()
                    : ArticleWidget(article: state.articles[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articleBloc.dispatch(FetchArticle());
    }
  }
}
