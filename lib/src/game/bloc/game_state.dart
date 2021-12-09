part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final Arena arena;
  final List<Insect> player1Hand;
  final List<Insect> player2Hand;
  final String player1Name;
  final String player2Name;

  GameState(this.arena, this.player1Name, this.player2Name, this.player1Hand,
      this.player2Hand);
}

class GameInitial extends GameState {
  GameInitial({
    required Arena arena,
    required String player1Name,
    required String player2Name,
    required List<Insect> player1Hand,
    required List<Insect> player2Hand,
  }) : super(arena, player1Name, player2Name, player1Hand, player2Hand);
}

class Player1Turn extends GameState {
  Player1Turn({
    required Arena arena,
    required String player1Name,
    required String player2Name,
    required List<Insect> player1Hand,
    required List<Insect> player2Hand,
  }) : super(arena, player1Name, player2Name, player1Hand, player2Hand);
}

class Player2Turn extends GameState {
  Player2Turn({
    required Arena arena,
    required String player1Name,
    required String player2Name,
    required List<Insect> player1Hand,
    required List<Insect> player2Hand,
  }) : super(arena, player1Name, player2Name, player1Hand, player2Hand);
}
