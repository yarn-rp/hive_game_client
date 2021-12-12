part of 'game_p_vs_ai_bloc.dart';

abstract class GamePVsAiState {
  final Arena arena;
  final List<Insect> myHand;
  final List<Insect> aiHand;
  final String name;

  const GamePVsAiState(
    this.arena,
    this.name,
    this.aiHand,
    this.myHand,
  );
}

class GameInitial extends GamePVsAiState {
  GameInitial({
    required Arena arena,
    required String name,
    required List<Insect> myHand,
    required List<Insect> aiHand,
  }) : super(arena, name, myHand, aiHand);
}

class Loading extends GamePVsAiState {
  Loading({
    required Arena arena,
    required String name,
    required List<Insect> myHand,
    required List<Insect> aiHand,
  }) : super(arena, name, myHand, aiHand);
}

class MyTurn extends GamePVsAiState {
  MyTurn({
    required Arena arena,
    required String name,
    required List<Insect> myHand,
    required List<Insect> aiHand,
  }) : super(arena, name, myHand, aiHand);
}

class AiTurn extends GamePVsAiState {
  AiTurn({
    required Arena arena,
    required String name,
    required List<Insect> myHand,
    required List<Insect> aiHand,
  }) : super(arena, name, myHand, aiHand);
}
