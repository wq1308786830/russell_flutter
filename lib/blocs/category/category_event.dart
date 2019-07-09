import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:russell_flutter/models/category.dart';

abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super(props);
}

class FetchCategory extends CategoryEvent {
  @override
  String toString() => 'category fetch';
}

class CategoryPressed extends CategoryEvent {
  final Category category;

  CategoryPressed({@required this.category}) : super([category]);

  @override
  String toString() => 'category press';
}
