import 'package:clicker/character_window.dart';
import 'package:clicker/click_button.dart';
import 'package:clicker/clicker_bloc.dart';
import 'package:clicker/components.dart';
import 'package:clicker/passive_buttons.dart';
import 'package:clicker/points_button.dart';
import 'package:clicker/total_score_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickerPage extends StatelessWidget {
  const ClickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ClickerView());
  }
}

class ClickerView extends StatelessWidget {
  const ClickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(),
        Expanded(flex: 10, child: ClickViewBody()),
        Spacer(),
      ],
    );
  }
}

class ClickViewBody extends StatelessWidget {
  const ClickViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 22),
          child: CharacterWindow(),
        ),
        Expanded(child: _Unlocks()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(height: 60, child: ClickButton()),
        ),
        square8,
      ],
    );
  }
}

class _Unlocks extends StatelessWidget {
  const _Unlocks();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ClickerBloc, ClickerState, List<UnlockStage>>(
      selector: (state) => state.unlocks,
      builder: (context, state) {
        final active = state.contains(UnlockStage.points);
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            _PointsAndTotal(active: active),
            for (final unlock in state) ...[
              if (unlock == UnlockStage.passive) ...[
                square8,
                _Passives(active: active),
              ],
              if (unlock == UnlockStage.messages) ...[],
            ],
          ],
        );
      },
    );
  }
}

class _Passives extends StatelessWidget {
  const _Passives({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return Row(
            children: [
              Expanded(child: BuyPassiveButton(active: active)),
              square8,
              Expanded(child: PassivesCounterButton(active: active)),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuyPassiveButton(active: active),
            square8,
            PassivesCounterButton(active: active),
          ],
        );
      },
    );
  }
}

class _PointsAndTotal extends StatelessWidget {
  const _PointsAndTotal({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return Row(
            children: [
              Expanded(child: PointsButton(active: active)),
              square8,
              Expanded(child: TotalScoreButton(active: active)),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PointsButton(active: active),
            square8,
            TotalScoreButton(active: active),
          ],
        );
      },
    );
  }
}
