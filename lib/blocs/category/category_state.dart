import 'package:equatable/equatable.dart';
import 'package:russell_flutter/models/category.dart';

abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryUninitialized extends CategoryState {
  @override
  String toString() => 'Category Unitialized';
}

class CategoryError extends CategoryState {
  @override
  String toString() => 'Category Error';
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories) : super(categories);

  CategoryLoaded copyWith(List<Category> categories) {
    return CategoryLoaded(categories ?? this.categories);
  }

  @override
  String toString() {
    return 'Category Loaded {ca}';
  }
}
