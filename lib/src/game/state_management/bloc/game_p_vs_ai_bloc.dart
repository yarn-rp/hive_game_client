import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_game_client/src/game/models/models.dart';

part 'game_p_vs_ai_event.dart';
part 'game_p_vs_ai_state.dart';

class GamePVsAiBloc extends Bloc<GamePVsAiEvent, GamePVsAiState> {
  final String playerName;

  GamePVsAiBloc(this.playerName)
      : super(GameInitial(
          arena: Arena(
            currentPlayerId: playerName,
            player1Insects: [],
            player2Insects: [],
          ),
          name: playerName,
          myHand: [],
          aiHand: [],
          // player1Hand: [
          //   QueenBee(
          //     name: 'Abeja reina',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   LadyBug(
          //     name: 'Mariquita',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   Grasshopper(
          //     name: 'Saltamontes',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   Spider(
          //     name: 'Araña',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   SoldierAnt(
          //     name: 'hormiguita',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          // ],
          // player2Hand: [
          //   QueenBee(
          //     name: 'Abeja reina',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   LadyBug(
          //     name: 'Mariquita',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   Grasshopper(
          //     name: 'Saltamontes',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   Spider(
          //     name: 'Araña',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          //   SoldierAnt(
          //     name: 'hormiguita',
          //     position: Position(0, 0),
          //     possiblePositions: [
          //       Position(1, 0),
          //       Position(1, -1),
          //       Position(0, -1),
          //       Position(-1, -0),
          //       Position(-1, 1),
          //       Position(0, 1),
          //     ],
          //   ),
          // ],
        )) {
    on<GamePVsAiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
