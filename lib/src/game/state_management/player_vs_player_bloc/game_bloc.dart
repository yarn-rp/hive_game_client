import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_game_client/core/error/failures.dart';

import 'package:hive_game_client/src/game/models/arena/arena.dart';
import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/player/player.dart';
import 'package:hive_game_client/src/game/models/position/position.dart';
import 'package:hive_game_client/src/game/repository/game_repository.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GamePvsPBloc extends Bloc<GamePvsPEvent, GamePvsPState> {
  final String player1Name;
  final String player2Name;
  final GameRepository _repository;

  GamePvsPBloc(
    this.player1Name,
    this.player2Name,
    this._repository,
  ) : super(
          GamePvsPState(
            arena: Arena(
              currentPlayerId: player1Name,
              player1: Player('p1', player1Name, 0, false, false, 'p', []),
              player2: Player('p2', player1Name, 0, false, false, 'p', []),
              insects: [],
            ),
            player1Name: player1Name,
            player2Name: player2Name,
            player1Hand: [],
            player2Hand: [],
          ),
        ) {
    on<SetNewInsect>(setNewInsectHandler);
    on<ChangeInsectPosition>(changeInsectPositionHandler);
    on<NewGame>(newGameHandler);
    on<GetPossiblePlacements>(getPossiblePlacementsHandler);
    on<GetPossibleMovements>(getPossibleMovementsHandler);

    add(NewGame(player1Name, player2Name));
  }

  FutureOr<void> newGameHandler(
    NewGame event,
    Emitter<GamePvsPState> emit,
  ) async {
    log('GOing to ask for init to the repository');
    final _arenaOrFailure = await _repository.startNewGamePvsP();
    emit(
      _arenaOrFailure.fold(
        (l) {
          log('Got error: $l');
          return GamePvsPState(
            failure: l,
            arena: state.arena,
            player1Name: state.player1Name,
            player2Name: state.player2Name,
            player1Hand: state.player1Hand,
            player2Hand: state.player2Hand,
          );
        },
        (r) {
          r.insects.sort((a, e) => e.level.compareTo(a.level));
          log('Got response properly');
          return GamePvsPState(
            arena: r,
            player1Name: state.player1Name,
            player2Name: state.player2Name,
            player1Hand: r.player1.insects,
            player2Hand: r.player2.insects,
          );
        },
      ),
    );
  }

  FutureOr<void> setNewInsectHandler(
    SetNewInsect event,
    Emitter<GamePvsPState> emit,
  ) async {
    log('Setting insect ');
    final _setNewInsectOrFailure =
        await _repository.placeNewInsect(event.insect.type, event.position);
    emit(_setNewInsectOrFailure.fold(
        (l) => GamePvsPState(
              failure: l,
              arena: state.arena,
              player1Name: state.player1Name,
              player2Name: state.player2Name,
              player1Hand: state.player1Hand,
              player2Hand: state.player2Hand,
            ), (r) {
      r.insects.sort((a, e) => e.level.compareTo(a.level));

      if (r.currentPlayerId == 'p1') {
        log('Got response properly');
        return GamePvsPState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      } else {
        log('Got response properly');
        return GamePvsPState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      }
    }));
  }

  FutureOr<void> changeInsectPositionHandler(
    ChangeInsectPosition event,
    Emitter<GamePvsPState> emit,
  ) async {
    log('Moving insect ');
    final _setNewInsectOrFailure =
        await _repository.moveInsect(event.insect, event.position, event.level);
    emit(_setNewInsectOrFailure.fold(
        (l) => GamePvsPState(
              failure: l,
              arena: state.arena,
              player1Name: state.player1Name,
              player2Name: state.player2Name,
              player1Hand: state.player1Hand,
              player2Hand: state.player2Hand,
            ), (r) {
      r.insects.sort((a, e) => e.level.compareTo(a.level));

      if (r.currentPlayerId == 'p1') {
        log('Got response properly');
        return GamePvsPState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      } else {
        log('Got response properly');
        return GamePvsPState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      }
    }));
  }

  FutureOr<void> getPossiblePlacementsHandler(
    GetPossiblePlacements event,
    Emitter<GamePvsPState> emit,
  ) async {
    log('On set Insect');

    final _possiblePositionsOrFailure =
        await _repository.getPossiblePlacements(event.insect.type);

    emit(_possiblePositionsOrFailure.fold(
      (l) => GamePvsPState(
        failure: l,
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
      (r) => GamePvsPState(
        insectSelectedData: Tuple2(event.insect, r),
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
    ));
  }

  FutureOr<void> getPossibleMovementsHandler(
    GetPossibleMovements event,
    Emitter<GamePvsPState> emit,
  ) async {
    log('On set Insect');

    final _possiblePositionsOrFailure = await _repository.getPossibleMovements(
        event.insect.type, event.insect.id, event.position);

    emit(_possiblePositionsOrFailure.fold(
      (l) => GamePvsPState(
        failure: l,
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
      (r) => GamePvsPState(
        insectSelectedData: Tuple2(event.insect, r),
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
    ));
  }
}
