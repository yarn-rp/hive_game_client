import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:fpdart/fpdart.dart';
import 'package:hive_game_client/core/error/failures.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/models/player/player.dart';
import 'package:hive_game_client/src/game/repository/game_repository.dart';

part 'game_p_vs_ai_event.dart';
part 'game_p_vs_ai_state.dart';

class GamePvsAIBloc extends Bloc<GamePVsAiEvent, GamePvsAiState> {
  final String player1Name;
  final String player2Name;
  final GameRepository _repository;

  GamePvsAIBloc(
    this.player1Name,
    this.player2Name,
    this._repository,
  ) : super(
          GamePvsAiState(
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
    add(NewGame(player1Name));
  }

  FutureOr<void> newGameHandler(
    NewGame event,
    Emitter<GamePvsAiState> emit,
  ) async {
    log('GOing to ask for init to the repository');
    final _arenaOrFailure = await _repository.startNewGamePvsAI();
    emit(
      _arenaOrFailure.fold(
        (l) {
          log('Got error: $l');
          return GamePvsAiState(
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
          return GamePvsAiState(
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
    Emitter<GamePvsAiState> emit,
  ) async {
    log('Setting insect ');
    final _setNewInsectOrFailure = await _repository.placeNewInsectForAI(
        event.insect.type, event.position);
    emit(_setNewInsectOrFailure.fold(
        (l) => GamePvsAiState(
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
        return GamePvsAiState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      } else {
        log('Got response properly');
        return GamePvsAiState(
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
    Emitter<GamePvsAiState> emit,
  ) async {
    log('Moving insect ');
    final _setNewInsectOrFailure = await _repository.moveInsectForAI(
        event.insect, event.position, event.level);
    emit(_setNewInsectOrFailure.fold(
        (l) => GamePvsAiState(
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
        return GamePvsAiState(
          arena: r,
          player1Name: state.player1Name,
          player2Name: state.player2Name,
          player1Hand: r.player1.insects,
          player2Hand: r.player2.insects,
        );
      } else {
        log('Got response properly');
        return GamePvsAiState(
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
    Emitter<GamePvsAiState> emit,
  ) async {
    log('On set Insect');

    final _possiblePositionsOrFailure =
        await _repository.getPossiblePlacementsForAI(event.insect.type);

    emit(_possiblePositionsOrFailure.fold(
      (l) => GamePvsAiState(
        failure: l,
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
      (r) => GamePvsAiState(
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
    Emitter<GamePvsAiState> emit,
  ) async {
    log('On set Insect');

    final _possiblePositionsOrFailure =
        await _repository.getPossibleMovementsForAI(
            event.insect.type, event.insect.id, event.position);

    emit(_possiblePositionsOrFailure.fold(
      (l) => GamePvsAiState(
        failure: l,
        arena: state.arena,
        player1Name: state.player1Name,
        player2Name: state.player2Name,
        player1Hand: state.player1Hand,
        player2Hand: state.player2Hand,
      ),
      (r) => GamePvsAiState(
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
