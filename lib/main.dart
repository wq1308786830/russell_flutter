import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/routes/article/article_detail.dart';
import 'package:russell_flutter/routes/home/home.dart';

import 'blocs/blocs.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    child: MyApp(),
    providers: <BlocProvider>[
      BlocProvider<CategoryBloc>(
        builder: (context) => CategoryBloc(),
      ),
      BlocProvider<ArticleBloc>(
        builder: (context) => ArticleBloc(),
      ),
      BlocProvider<ArticleDetailBloc>(
        builder: (context) => ArticleDetailBloc(),
      ),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/articleDetail': (context) => ArticleDetail(),
      },
    );
  }
}
