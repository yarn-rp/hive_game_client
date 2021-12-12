part of 'game_p_vs_ai_bloc.dart';

class GamePvsAiState {
  final Arena arena;
  final List<Insect> player1Hand;
  final Tuple2<Insect, List<Position>>? insectSelectedData;
  final Failure? failure;
  final List<Insect> player2Hand;
  final String player1Name;
  final String player2Name;

  const GamePvsAiState({
    required this.arena,
    required this.player1Name,
    required this.player2Name,
    required this.player1Hand,
    required this.player2Hand,
    this.insectSelectedData,
    this.failure,
  });
}
