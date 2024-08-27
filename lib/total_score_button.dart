import 'package:clicker/click_button.dart';
import 'package:clicker/clicker_bloc.dart';
import 'package:clicker/components.dart';
import 'package:clicker/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class TotalScoreButton extends StatelessWidget {
  const TotalScoreButton({required this.active, super.key});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.score,
      builder: (context, state) {
        return NesButton.text(
          text: 'score: $state',
          type: NesButtonType.normal,
          onPressed: !active
              ? null
              : () => showGameMessage<void>(
                    context: context,
                    message: [
                      const TextSpan(text: 'Your '),
                      TextSpan(
                        text: 'total score',
                        style: context.emphasis,
                      ),
                      const TextSpan(
                        text: ' is total amount of ',
                      ),
                      TextSpan(text: 'points', style: context.emphasis),
                      const TextSpan(
                        text: ' you have gained over the course of '
                            'the game.',
                      ),
                    ],
                    child: const Column(
                      children: [
                        NesContainer(
                          child: Column(
                            children: [
                              Text('score:'),
                              ScoreText(),
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

class ScoreText extends StatelessWidget {
  const ScoreText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, int>(
      selector: (state) => state.score,
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}

class TotalScoreButtonEnabled extends StatelessWidget {
  const TotalScoreButtonEnabled({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, bool>(
      selector: (state) => state.unlocks.contains(UnlockStage.points),
      builder: (context, state) {
        return AnimatedOpacity(
          duration: Durations.medium1,
          opacity: state ? 1 : 0,
          child: state
              ? const TotalScoreButton(active: true)
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
