import 'package:clicker/clicker_bloc.dart';
import 'package:clicker/components.dart';
import 'package:clicker/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class BuyPassiveButton extends StatelessWidget {
  const BuyPassiveButton({
    required this.active,
    super.key,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, (bool, int)>(
      selector: (state) => (state.canAffordPassive, state.passiveCost),
      builder: (context, state) {
        return NesButton.text(
          text: 'buy passive: ${state.$2}',
          type: NesButtonType.primary,
          onPressed: state.$1 && active
              ? () => context.read<ClickerBloc>().add(BuyPassiveEvent(state.$2))
              : null,
        );
      },
    );
  }
}

class PassivesCounterButton extends StatelessWidget {
  const PassivesCounterButton({
    required this.active,
    super.key,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.passives,
      builder: (context, state) {
        return NesButton.text(
          text: 'passives: $state',
          type: NesButtonType.normal,
          onPressed: () {
            showGameMessage<void>(
              context: context,
              message: [
                const TextSpan(text: 'Your '),
                TextSpan(text: 'passives', style: context.emphasis),
                const TextSpan(text: ' provide '),
                TextSpan(text: '1 point', style: context.emphasis),
                const TextSpan(text: ' per passive per second.'),
              ],
              child: Column(
                children: [
                  const NesContainer(
                    child: Column(
                      children: [
                        Text('passives:'),
                        PassivesText(),
                      ],
                    ),
                  ),
                  square8,
                  BuyPassiveButton(active: active),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class PassivesText extends StatelessWidget {
  const PassivesText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.passives,
      builder: (context, state) => Text('$state'),
    );
  }
}
