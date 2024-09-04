import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebapp/infrastructure/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  List<ItemModel> items = [];

  MainBloc() : super(ItemsLoading()) {
    on<LoadItems>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? itemsString = prefs.getString('items');
      if (itemsString != null) {
        final List<dynamic> jsonList = jsonDecode(itemsString);
        items = jsonList
            .map((jsonString) => ItemModel.fromJson(jsonDecode(jsonString)))
            .toList();
      } else {
        items = [
          ItemModel(id: 1, title: "The Catcher in the Rye"),
          ItemModel(id: 2, title: "To Kill a Mockingbird"),
          ItemModel(id: 3, title: "1984"),
          ItemModel(id: 4, title: "Pride and Prejudice"),
          ItemModel(id: 5, title: "The Great Gatsby"),
        ];
      }
      emit(ItemsLoaded(items));
    });

    on<AddItem>((event, emit) async {
      emit(ItemAdding());
      await Future.delayed(const Duration(seconds: 2));
      items.add(ItemModel(id: items.length + 1, title: event.title));

      final prefs = await SharedPreferences.getInstance();
      final List<String> jsonStringList =
          items.map((item) => jsonEncode(item.toJson())).toList();
      await prefs.setString('items', jsonEncode(jsonStringList));

      emit(ItemsLoaded(items));
    });
  }
}
