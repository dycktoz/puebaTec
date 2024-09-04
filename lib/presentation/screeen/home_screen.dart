import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebapp/presentation/bloc/main_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Elementos')),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is ItemsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemsLoaded) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title),
                );
              },
            );
          } else if (state is ItemAdding) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Agregar nuevo elemento'),
                content: Builder(
                  builder: (BuildContext context) {
                    return Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(hintText: "Nombre"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre del elemento no puede estar vacío';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        final mainBloc = BlocProvider.of<MainBloc>(context);
                        mainBloc.add(AddItem(controller.text));
                        controller.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Agregar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
