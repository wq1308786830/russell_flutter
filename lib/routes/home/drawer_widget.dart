import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/models/category.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryBloc _bloc = BlocProvider.of<CategoryBloc>(context);

    return BlocBuilder<CategoryEvent, CategoryState>(
      bloc: _bloc,
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
          return ListView.builder(
            padding: EdgeInsetsDirectional.only(start: 60, top: 100),
            itemCount: state.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Category category = state.categories[index];
                  _bloc.dispatch(CategoryPressed(category: category));
                  Navigator.pop(context);
                },
                title: Text(state.categories[index].name)
              );
            });
        }
      });
  }
}
