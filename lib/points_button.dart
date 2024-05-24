import 'package:clicker/click_button.dart';
import 'package:clicker/clicker_bloc.dart';
import 'package:clicker/components.dart';
import 'package:clicker/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class PointsButton extends StatelessWidget {
  const PointsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.points,
      builder: (context, state) {
        return NesButton.text(
          text: 'points: $state',
          type: NesButtonType.normal,
          onPressed: () => showGameMessage<void>(
            context: context,
            message: [
              const TextSpan(text: 'Your '),
              TextSpan(text: 'points', style: context.emphasis),
              const TextSpan(text: ' are available values to '),
              TextSpan(text: 'spend', style: context.emphasis),
              const TextSpan(text: ' on '),
              TextSpan(text: 'upgrades', style: context.emphasis),
              const TextSpan(text: '.'),
            ],
            child: const Column(
              children: [
                NesContainer(
                  child: Column(
                    children: [
                      Text('points:'),
                      PointsText(),
                    ],
                  ),
                ),
                square8,
                ClickButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PointsText extends StatelessWidget {
  const PointsText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.points,
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}
