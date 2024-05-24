import 'package:clicker/clicker_bloc.dart';
import 'package:clicker/clicker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

void main() => runApp(const ClickerApp());

class ClickerApp extends StatelessWidget {
  const ClickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ClickerBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: flutterNesTheme(),
        home: const ClickerPage(),
      ),
    );
  }
}
