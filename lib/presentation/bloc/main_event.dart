part of 'main_bloc.dart';

abstract class MainEvent {}

class LoadItems extends MainEvent {}

class AddItem extends MainEvent {
  final String title;

  AddItem(this.title);
}
