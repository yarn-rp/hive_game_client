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
  Future<Response<Map<String, dynamic>>> getCurrentArena() {
    final $url = '/game/arena';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> startNewGame(String mode, int level) {
    final $url = '/game';
    final $body = <String, dynamic>{'mode': mode, 'level': level};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> quitGame(String arenaId) {
    final $url = 'game/quitGame';
    final $body = <String, dynamic>{'arenaId': arenaId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPossiblePlacements(String type) {
    final $url = '/insect/place/available';
    final $body = <String, dynamic>{'type': type};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPossibleMoves(
      String type, int id, List<int> hexagon) {
    final $url = '/insect/move/available';
    final $body = <String, dynamic>{'type': type, 'id': id, 'hexagon': hexagon};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> movePiece(String type, int id, int lvl,
      List<dynamic> origin, List<dynamic> destiny) {
    final $url = '/insect/move';
    final $body = <String, dynamic>{
      'type': type,
      'id': id,
      'lvl': lvl,
      'hexagon_ori': origin,
      'hexagon_end': destiny
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> placeInsect(
      String type, List<dynamic> newPlace) {
    final $url = '/insect/place';
    final $body = <String, dynamic>{'type': type, 'hexagon': newPlace};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> playAI() {
    final $url = '/ai';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
