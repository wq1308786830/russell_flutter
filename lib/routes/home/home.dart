import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russell_flutter/blocs/article/article_bloc.dart';
import 'package:russell_flutter/blocs/blocs.dart';
import 'package:russell_flutter/components/category_cascade.dart';
import 'package:russell_flutter/routes/articles/article_list.dart';

class Home extends StatelessWidget {

  void onCategoryChange(value) {
    print(value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListTile(
            contentPadding: EdgeInsetsDirectional.only(top: 80),
            leading: Icon(Icons.change_history),
            title: Text('Change history'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
        ),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          child: Column(

            children: <Widget>[
              CategoryCascade(onCategoryChange: this.onCategoryChange),
              Text('body'),
              Flexible(
                child: BlocProvider(
                  builder: (context) =>
                  ArticleBloc(httpClient: http.Client())..dispatch(FetchArticle()),
                  child: ArticleList(),
                ),
              )
            ],
          )
        ));
  }

  Widget _buildList() => ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      Divider(),
      _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile(
          'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
