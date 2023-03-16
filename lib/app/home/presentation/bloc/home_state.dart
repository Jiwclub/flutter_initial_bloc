part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class NewsLoading extends HomeState {}

class NewsSuccess extends HomeState {
  final List<Products>? products;

  NewsSuccess(this.products);
}
