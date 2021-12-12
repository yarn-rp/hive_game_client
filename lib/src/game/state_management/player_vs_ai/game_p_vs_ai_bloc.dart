import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/models/player/player.dart';

part 'game_p_vs_ai_event.dart';
part 'game_p_vs_ai_state.dart';

class GamePVsAiBloc extends Bloc<GamePVsAiEvent, GamePVsAiState> {
  final String playerName;

  GamePVsAiBloc(this.playerName)
      : super(GameInitial(
          arena: Arena(
            currentPlayerId: playerName,
            player1: Player('p1', playerName, 0, false, false, 'p', []),
            player2: Player('p2', 'Hive-Ai', 0, false, false, 'ai', []),
            insects: [],
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
    on<SetNewInsect>(setNewInsectHandler);
    on<ChangeInsectPosition>(changeInsectPositionHandler);
  }
  FutureOr<void> setNewInsectHandler(
    SetNewInsect event,
    Emitter<GamePVsAiState> emit,
  ) {
    log('On set Insect');

    log('Going to chance to player2 Insect');

    // emit(
    //   AiTurn(
    //     arena: state.arena
    //       ..player1.insects.add(event.insect.copyWith(
    //             position: event.position,
    //           )),
    //     name: playerName,
    //     myHand: state.myHand..remove(event.insect),
    //     aiHand: state.aiHand,
    //   ),
    // );
  }

  FutureOr<void> changeInsectPositionHandler(
    ChangeInsectPosition event,
    Emitter<GamePVsAiState> emit,
  ) {
    log('On set Insect');

    log('Going to chance to player2 Insect');

    // emit(
    //   AiTurn(
    //     arena: state.arena
    //       ..player2.insects.add(event.insect.copyWith(
    //             position: event.position,
    //           )),
    //     name: playerName,
    //     myHand: state.myHand..remove(event.insect),
    //     aiHand: state.aiHand,
    //   ),
    // );
  }
}
