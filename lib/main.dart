import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebapp/presentation/bloc/main_bloc.dart';
import 'package:pruebapp/presentation/screeen/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => MainBloc()..add(LoadItems()),
        child: const HomeScreen(),
      ),
    );
  }
}
