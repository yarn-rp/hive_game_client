// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_game_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$HiveGameService extends HiveGameService {
  _$HiveGameService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HiveGameService;

  @override
  Future<Response<Either<Failure, Arena>>> getCurrentArena(String arenaId) {
    final $url = '/getArena';
    final $params = <String, dynamic>{'arenaId': arenaId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Either<Failure, Arena>, Failure>($request,
        responseConverter: HiveGameConverter.convertResponseArena);
  }

  @override
  Future<Response<Either<Failure, Arena>>> startNewGame(
      String playerId1, String playerId2) {
    final $url = '/newGame';
    final $body = <String, dynamic>{
      'playerId1': playerId1,
      'playerId2': playerId2
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Either<Failure, Arena>, Failure>($request);
  }

  @override
  Future<Response<Either<Failure, Arena>>> quitGame(String arenaId) {
    final $url = '/quitGame';
    final $body = <String, dynamic>{'arenaId': arenaId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Either<Failure, Arena>, Failure>($request);
  }

  @override
  Future<Response<Either<Failure, Arena>>> movePiece(
      Map<String, dynamic> insect, Map<String, dynamic> coordinates) {
    final $url = '/movePiece';
    final $body = <String, dynamic>{
      'insect': insect,
      'newCoordinates': coordinates
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Either<Failure, Arena>, Failure>($request);
  }
}
