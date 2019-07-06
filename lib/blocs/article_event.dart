import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class Fetch extends ArticleEvent {

  @override
  String toString() => 'Fetch';
}