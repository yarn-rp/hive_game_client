part of 'game_bloc.dart';

@immutable
class GamePvsPState {
  final Arena arena;
  final List<Insect> player1Hand;
  final Tuple2<Insect, List<Position>>? insectSelectedData;
  final Failure? failure;
  final List<Insect> player2Hand;
  final String player1Name;
  final String player2Name;

  const GamePvsPState({
    required this.arena,
    required this.player1Name,
    required this.player2Name,
    required this.player1Hand,
    required this.player2Hand,
    this.insectSelectedData,
    this.failure,
  });
}
