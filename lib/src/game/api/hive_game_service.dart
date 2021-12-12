import 'package:chopper/chopper.dart';

part 'hive_game_service.chopper.dart';

@ChopperApi()
abstract class HiveGameService extends ChopperService {
  static HiveGameService create([ChopperClient? client]) =>
      _$HiveGameService(client);

  @Get(path: '/hive_api/game/game_stats')
  Future<Response<Map<String, dynamic>>> getCurrentArena();

  @Post(path: '/hive_api/game/new_game')
  Future<Response<Map<String, dynamic>>> startNewGame(
    @Field('mode') String mode,
    @Field('level') int level,
  );

  @Post(path: 'game/quitGame')
  Future<Response<Map<String, dynamic>>> quitGame(
    @Field('arenaId') String arenaId,
  );

  @Post(path: '/hive_api/insect/get_possible_placements')
  Future<Response<Map<String, dynamic>>> getPossiblePlacements(
    @Field('type') String type,
  );
  @Post(path: '/hive_api/insect/get_possible_moves')
  Future<Response<Map<String, dynamic>>> getPossibleMoves(
    @Field('type') String type,
    @Field('id') int id,
    @Field('hexagon') List<int> hexagon,
  );

  @Post(path: '/hive_api/insect/move_insect')
  Future<Response<Map<String, dynamic>>> movePiece(
    @Field() String type,
    @Field() int id,
    @Field() int lvl,
    @Field('hexagon_ori') List origin,
    @Field('hexagon_end') List destiny,
  );

  @Post(path: '/hive_api/insect/place_insect')
  Future<Response<Map<String, dynamic>>> placeInsect(
    @Field() String type,
    @Field('hexagon') List newPlace,
  );
}
