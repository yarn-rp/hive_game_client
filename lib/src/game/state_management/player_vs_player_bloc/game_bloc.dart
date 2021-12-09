import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_game_client/src/game/api/hive_game_service.dart';
import 'package:hive_game_client/src/game/models/arena/arena.dart';
import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/position/position.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GamePvsPBloc extends Bloc<GamePvsPEvent, GamePvsPState> {
  final String player1Name;
  final String player2Name;
  // final HiveGameService _apiService;

  GamePvsPBloc(
    this.player1Name,
    this.player2Name,
  ) : super(Player1Turn(
          arena: Arena(
            currentPlayerId: player1Name,
            player1Insects: [],
            player2Insects: [],
          ),
          player1Name: player1Name,
          player2Name: player2Name,
          player1Hand: [],
          player2Hand: [],
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
    on<SetNewInsect>(setNewInsectHandler);
  }

  FutureOr<void> setNewInsectHandler(
    SetNewInsect event,
    Emitter<GamePvsPState> emit,
  ) {
    log('On set Insect');
    if (state is Player1Turn) {
      log('Going to chance to player2 Insect');

      emit(
        Player2Turn(
          arena: state.arena
            ..player1Insects.add(event.insect.copyWith(
              position: event.position,
            )),
          player1Name: player1Name,
          player2Name: player2Name,
          player1Hand: state.player1Hand..remove(event.insect),
          player2Hand: state.player2Hand,
        ),
      );
    } else {
      if (state is Player2Turn) {
        log('Going to chance to player1 Insect');
        emit(
          Player1Turn(
            arena: state.arena
              ..player2Insects.add(event.insect.copyWith(
                position: event.position,
              )),
            player1Name: player1Name,
            player2Name: player2Name,
            player1Hand: state.player1Hand,
            player2Hand: state.player2Hand..remove(event.insect),
          ),
        );
      }
    }
  }
}
