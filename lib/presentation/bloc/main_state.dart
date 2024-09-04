part of 'main_bloc.dart';

abstract class MainState {}

class ItemsLoading extends MainState {}

class ItemsLoaded extends MainState {
  final List<ItemModel> items;

  ItemsLoaded(this.items);
}

class ItemAdding extends MainState {}
