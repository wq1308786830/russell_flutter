import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class FetchCategory extends CategoryEvent {
  @override
  String toString() => 'category fetch';
}