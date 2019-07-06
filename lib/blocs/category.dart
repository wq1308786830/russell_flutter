import 'package:flutter/material.dart';

class CategoryBloc extends ChangeNotifier {
  List<dynamic> _categories;

  List<dynamic> get categories => _categories;

  set categories(List<dynamic> newValue) {
    _categories = newValue;
    notifyListeners();
  }
}