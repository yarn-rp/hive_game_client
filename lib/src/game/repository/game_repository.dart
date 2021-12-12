import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import 'package:hive_game_client/core/error/failures.dart';
import 'package:hive_game_client/src/game/api/hive_game_service.dart';
import 'package:hive_game_client/src/game/models/arena/arena.dart';
import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/player/player.dart';
import 'package:hive_game_client/src/game/models/position/position.dart';

import 'package:injectable/injectable.dart';

@Injectable()
class GameRepository {
  final HiveGameService _apiService;

  GameRepository(this._apiService);

  Future<Either<Failure, Arena>> getCurrentArena() async {
    try {
      final _arenaResponse = await _apiService.getCurrentArena();

      if (_arenaResponse.isSuccessful &&
          _arenaResponse.body!['status_code'] == 200) {
        final _body = _arenaResponse.body!;

        final _hiveInsects = (_body['hive'] as List);
        log('Hive insects are: $_hiveInsects');
        final p1Info = (_body['players_info'] as Map<String, dynamic>)['p1'];

        final p2Info = (_body['players_info'] as Map<String, dynamic>)['p2'];
        final _p1 = Player(
          p1Info['id'],
          p1Info['name'],
          p1Info['movesCount'],
          p1Info['isGameOver'],
          p1Info['hasQueenOnArena'],
          p1Info['type'],
          [...(p1Info['hand'] as List).map((e) => Insect.fromJson(e))],
        );
        final _p2 = Player(
          p2Info['id'],
          p2Info['name'],
          p2Info['movesCount'],
          p2Info['isGameOver'],
          p2Info['hasQueenOnArena'],
          p2Info['type'],
          [...(p2Info['hand'] as List).map((e) => Insect.fromJson(e))],
        );
        log('Player 1 insects is: ${_p1.insects}');
        log('Player 2 insects is: ${_p2.insects}');
        return right(Arena(
          currentPlayerId: _body['current_player_id'],
          player1: _p1,
          player2: _p2,
          insects: [..._hiveInsects.map((e) => Insect.fromJson(e))],
        ));
      } else {
        log('Response for getCurretArena was not successfull: $_arenaResponse.statusCode');
        return Left(ServerFailure(message: '${_arenaResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Cathing error $e');
      return const Left(NoInternetConnectionFailure());
    }
  }

  Future<Either<Failure, List<Position>>> getPossibleMovements(
    String type,
    int id,
    Position hexagon,
  ) async {
    try {
      final _initGameResponse =
          await _apiService.getPossibleMoves(type, id, [hexagon.x, hexagon.y]);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.body!['status_code'] == 200) {
        log('Movements returned ${_initGameResponse.body!}');
        final _placements = (_initGameResponse.body!['moves'] as List).map((e) {
          log('Position: $e');
          return Position(e[0], e[1]);
        });
        log('Posible moves: $_placements');

        return right([..._placements]);
      } else {
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> placeNewInsect(
    String type,
    Position hexagon,
  ) async {
    try {
      log('Placing insect $type in $hexagon');
      final _initGameResponse = await _apiService.placeInsect(type, [
        hexagon.x,
        hexagon.y,
      ]);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.body!['status_code'] == 200) {
        log('Place insect returned: ${_initGameResponse.body!}');
        return getCurrentArena();
      } else {
        log('Response is not succesfull, ${_initGameResponse.statusCode}');

        // return right([Position(0, 1)]);
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Error: $e');
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> moveInsect(
    Insect _insect,
    Position hexagon,
    int level,
  ) async {
    try {
      final _initGameResponse =
          await _apiService.movePiece(_insect.type, _insect.id, level, [
        _insect.position!.x,
        _insect.position!.y,
      ], [
        hexagon.x,
        hexagon.y,
      ]);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.statusCode == 200) {
        log('Place insect returned: ${_initGameResponse.body!}');
        return getCurrentArena();
      } else {
        log('Response is not succesfull, ${_initGameResponse.statusCode}');

        // return right([Position(0, 1)]);
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Error: $e');
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Position>>> getPossiblePlacements(
      String type) async {
    try {
      final _initGameResponse = await _apiService.getPossiblePlacements(type);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.body!['status_code'] == 200) {
        log('Placements returned ${_initGameResponse.body!}');
        final _placements =
            (_initGameResponse.body!['placements'] as List).map((e) {
          log('Position: $e');
          return Position(e[0], e[1]);
        });

        return right([..._placements]);
      } else {
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> startNewGamePvsP() async {
    try {
      log('starting ew game');
      final _initGameResponse = await _apiService.startNewGame('pvp', 1);
      log('Got response for init game');
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.statusCode == 200) {
        log('Response is ok');
        log('going to get the arena');

        return getCurrentArena();
      } else {
        log('Response is not ok: ${_initGameResponse.statusCode}');
        return const Left(ServerFailure());
      }
    } catch (e) {
      log('Cath error $e');
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> startNewGamePvsAI() async {
    try {
      log('starting ew game');
      final _initGameResponse = await _apiService.startNewGame('pvai', 1);
      log('Got response for init game');
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.statusCode == 200) {
        log('Response is ok');
        log('going to get the arena');

        return getCurrentArena();
      } else {
        log('Response is not ok: ${_initGameResponse.statusCode}');
        return const Left(ServerFailure());
      }
    } catch (e) {
      log('Cath error $e');
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> getCurrentArenaForAI() async {
    try {
      final _aIPLay = await _playAI();
      if (_aIPLay.isLeft()) {
        return left((_aIPLay.getLeft()).match((t) => t, () => ServerFailure()));
      }
      final _arenaResponse = await _apiService.getCurrentArena();

      if (_arenaResponse.isSuccessful &&
          _arenaResponse.body!['status_code'] == 200) {
        final _body = _arenaResponse.body!;

        final _hiveInsects = (_body['hive'] as List);
        log('Hive insects are: $_hiveInsects');
        final p1Info = (_body['players_info'] as Map<String, dynamic>)['p1'];

        final p2Info = (_body['players_info'] as Map<String, dynamic>)['p2'];
        final _p1 = Player(
          p1Info['id'],
          p1Info['name'],
          p1Info['movesCount'],
          p1Info['isGameOver'],
          p1Info['hasQueenOnArena'],
          p1Info['type'],
          [...(p1Info['hand'] as List).map((e) => Insect.fromJson(e))],
        );
        final _p2 = Player(
          p2Info['id'],
          p2Info['name'],
          p2Info['movesCount'],
          p2Info['isGameOver'],
          p2Info['hasQueenOnArena'],
          p2Info['type'],
          [...(p2Info['hand'] as List).map((e) => Insect.fromJson(e))],
        );
        log('Player 1 insects is: ${_p1.insects}');
        log('Player 2 insects is: ${_p2.insects}');
        return right(Arena(
          currentPlayerId: _body['current_player_id'],
          player1: _p1,
          player2: _p2,
          insects: [..._hiveInsects.map((e) => Insect.fromJson(e))],
        ));
      } else {
        log('Response for getCurretArena was not successfull: $_arenaResponse.statusCode');
        return Left(ServerFailure(message: '${_arenaResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Cathing error $e');
      return const Left(NoInternetConnectionFailure());
    }
  }

  Future<Either<Failure, List<Position>>> getPossibleMovementsForAI(
    String type,
    int id,
    Position hexagon,
  ) async {
    try {
      final _movesResponse =
          await _apiService.getPossibleMoves(type, id, [hexagon.x, hexagon.y]);
      log('El body de possible moves es: ${_movesResponse.isSuccessful}');
      if (_movesResponse.isSuccessful &&
          _movesResponse.body!['status_code'] == 200) {
        log('Movements returned ${_movesResponse.body!}');
        final _placements = (_movesResponse.body!['moves'] as List).map((e) {
          log('Position: $e');
          return Position(e[0], e[1]);
        });
        log('Posible moves: $_placements');

        return right([..._placements]);
      } else {
        return Left(ServerFailure(message: '${_movesResponse.body!["msg"]}'));
      }
    } catch (e) {
      log("Possibles moves error: $e");
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> placeNewInsectForAI(
    String type,
    Position hexagon,
  ) async {
    try {
      log('Placing insect $type in $hexagon');
      final _initGameResponse = await _apiService.placeInsect(type, [
        hexagon.x,
        hexagon.y,
      ]);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.body!['status_code'] == 200) {
        log('Place insect returned: ${_initGameResponse.body!}');
        return getCurrentArenaForAI();
      } else {
        log('Response is not succesfull, ${_initGameResponse.statusCode}');

        // return right([Position(0, 1)]);
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Error: $e');
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Arena>> moveInsectForAI(
    Insect _insect,
    Position hexagon,
    int level,
  ) async {
    try {
      final _initGameResponse =
          await _apiService.movePiece(_insect.type, _insect.id, level, [
        _insect.position!.x,
        _insect.position!.y,
      ], [
        hexagon.x,
        hexagon.y,
      ]);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.statusCode == 200) {
        log('Place insect returned: ${_initGameResponse.body!}');
        return getCurrentArenaForAI();
      } else {
        log('Response is not succesfull, ${_initGameResponse.statusCode}');

        // return right([Position(0, 1)]);
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Error: $e');
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Position>>> getPossiblePlacementsForAI(
      String type) async {
    try {
      final _initGameResponse = await _apiService.getPossiblePlacements(type);
      if (_initGameResponse.isSuccessful &&
          _initGameResponse.body!['status_code'] == 200) {
        log('Placements returned ${_initGameResponse.body!}');
        final _placements =
            (_initGameResponse.body!['placements'] as List).map((e) {
          log('Position: $e');
          return Position(e[0], e[1]);
        });

        return right([..._placements]);
      } else {
        return Left(
            ServerFailure(message: '${_initGameResponse.body!["msg"]}'));
      }
    } catch (e) {
      // return right([Position(0, 1)]);
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> _playAI() async {
    try {
      final _arenaResponse = await _apiService.playAI();

      if (_arenaResponse.isSuccessful &&
          _arenaResponse.body!['status_code'] == 200) {
        log('AI just played');
        return right(unit);
      } else {
        log('Response for playAI was not successfull: $_arenaResponse.statusCode');
        return Left(ServerFailure(message: '${_arenaResponse.body!["msg"]}'));
      }
    } catch (e) {
      log('Cathing error $e');
      return const Left(NoInternetConnectionFailure());
    }
  }
}
