import 'dart:async';

import 'package:bloc/bloc.dart';

abstract class ClickerEvent {
  const ClickerEvent();
}

class ClickEvent extends ClickerEvent {
  const ClickEvent();
}

class BuyPassiveEvent extends ClickerEvent {
  const BuyPassiveEvent(this.cost);
  final int cost;
}

class _InitializePassivesEvent extends ClickerEvent {
  const _InitializePassivesEvent();
}

class _PassivesTickEvent extends ClickerEvent {
  const _PassivesTickEvent();
}

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  ClickerBloc() : super(const ClickerState.initial()) {
    on<ClickEvent>(_onClickEvent);
    on<BuyPassiveEvent>(_onBuyPassiveEvent);
    on<_InitializePassivesEvent>(_onInitializePassivesEvent);
    on<_PassivesTickEvent>(
      (event, emit) => emit(
        state.copyWith(
          points: state.points + state.passives,
          score: state.score + state.passives,
        ),
      ),
    );
  }

  void _onBuyPassiveEvent(
    BuyPassiveEvent event,
    Emitter<ClickerState> emit,
  ) {
    if (state.passives < 1) add(const _InitializePassivesEvent());

    emit(
      state.copyWith(
        passives: state.passives + 1,
        // TODO(elijah): how should I increase passive costs?
        passiveCost: state.passiveCost + 5,
        points: state.points - event.cost,
      ),
    );
    _unlockMessages(emit);
  }

  Future<void> _onInitializePassivesEvent(
    _InitializePassivesEvent event,
    Emitter<ClickerState> emit,
  ) {
    return emit.onEach(
      Stream<void>.periodic(const Duration(seconds: 1)),
      onData: (_) {
        add(const _PassivesTickEvent());
        _unlockCharacter(emit);
      },
    );
  }

  void _unlockCharacter(Emitter<ClickerState> emit) {
    if (state.score > 149 && !state.unlocks.contains(UnlockStage.character)) {
      emit(state.copyWith(unlocks: [...state.unlocks, UnlockStage.character]));
    }
  }

  void _onClickEvent(
    ClickEvent event,
    Emitter<ClickerState> emit,
  ) {
    emit(
      state.copyWith(
        points: state.points + 1,
        score: state.score + 1,
      ),
    );

    _unlockPoints(emit);
    _unlockPassive(emit);
  }

  void _unlockPassive(Emitter<ClickerState> emit) {
    if (state.score > 19 && !state.unlocks.contains(UnlockStage.passive)) {
      emit(
        state.copyWith(
          unlocks: [...state.unlocks, UnlockStage.passive],
        ),
      );
    }
  }

  void _unlockPoints(Emitter<ClickerState> emit) {
    if (state.score > 9 && !state.unlocks.contains(UnlockStage.points)) {
      emit(
        state.copyWith(
          unlocks: [...state.unlocks, UnlockStage.points],
        ),
      );
    }
  }

  void _unlockMessages(Emitter<ClickerState> emit) {
    if (state.passives > 4 && !state.unlocks.contains(UnlockStage.messages)) {
      emit(
        state.copyWith(
          unlocks: [...state.unlocks, UnlockStage.messages],
        ),
      );
    }
  }
}

class ClickerState {
  const ClickerState({
    required this.score,
    required this.points,
    required this.unlocks,
    required this.passives,
    required this.passiveCost,
  });

  const ClickerState.initial()
      : points = 0,
        score = 0,
        passives = 0,
        passiveCost = 10,
        unlocks = const <UnlockStage>[];

  final int score;
  final int points;
  final int passives;
  final int passiveCost;
  final List<UnlockStage> unlocks;

  bool get canAffordPassive => points >= passiveCost;

  ClickerState copyWith({
    int? score,
    int? points,
    int? passives,
    int? passiveCost,
    List<UnlockStage>? unlocks,
  }) {
    return ClickerState(
      score: score ?? this.score,
      points: points ?? this.points,
      passives: passives ?? this.passives,
      passiveCost: passiveCost ?? this.passiveCost,
      unlocks: unlocks ?? this.unlocks,
    );
  }
}

enum UnlockStage { points, passive, character, messages }
