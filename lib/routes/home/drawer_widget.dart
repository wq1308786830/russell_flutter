import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/components/common/avatar.dart';
import 'package:russell_flutter/models/category.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ArticleBloc _articleBloc = BlocProvider.of<ArticleBloc>(context);
    final CategoryBloc _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return BlocBuilder<CategoryEvent, CategoryState>(
        bloc: _categoryBloc,
        builder: (BuildContext context, CategoryState state) {
          if (state is CategoryError) {
            return Center(child: Text('failed to fetch categories'));
          }
          if (state is CategoryUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryLoaded) {
            if (state.categories.isEmpty) {
              return Center(
                child: Text('no category'),
              );
            }
            return Column(
              children: <Widget>[
                Container(
                    height: 240.0,
                    width: double.infinity,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'http://img.pptjia.com/image/20180808/1df25220135e7dce8b0012a1f66ba8f8.png')),
                    ),
                    child: Avatar(
                        width: 80.0,
                        height: 80.0,
                        src:
                            'https://oss.biosan.cn/weichat/mine/WechatIMG1.jpeg')),
                Flexible(
                  child: ListView.builder(
                      padding: EdgeInsetsDirectional.only(start: 20, top: 20),
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              Category category = state.categories[index];
                              _articleBloc.dispatch(FetchClassifiedArticle(
                                  categoryId: category.id));
                              Navigator.pop(context);
                            },
                            title: Text(state.categories[index].name));
                      }),
                )
              ],
            );
          }
        });
  }
}
