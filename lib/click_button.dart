import 'package:clicker/clicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class ClickButton extends StatelessWidget {
  const ClickButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NesButton(
      type: NesButtonType.success,
      onPressed: () => context.read<ClickerBloc>().add(const ClickEvent()),
      child: const Center(child: Text('click')),
    );
  }
}
