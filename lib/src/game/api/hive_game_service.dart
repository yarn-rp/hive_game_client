import 'package:chopper/chopper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_game_client/core/error/failures.dart';
import 'package:hive_game_client/src/game/api/converters/hive_game_converter.dart';
import 'package:hive_game_client/src/game/models/models.dart';

part 'hive_game_service.chopper.dart';

@ChopperApi()
abstract class HiveGameService extends ChopperService {
  static HiveGameService create([ChopperClient? client]) =>
      _$HiveGameService(client);

  @FactoryConverter(
    response: HiveGameConverter.convertResponseArena,
  )
  @Get(path: '/getArena')
  Future<Response<Either<Failure, Arena>>> getCurrentArena(
    @Query('arenaId') String arenaId,
  );

  @Post(path: '/newGame')
  Future<Response<Either<Failure, Arena>>> startNewGame(
    @Field('playerId1') String playerId1,
    @Field('playerId2') String playerId2,
  );

  @Post(path: '/quitGame')
  Future<Response<Either<Failure, Arena>>> quitGame(
    @Field('arenaId') String arenaId,
  );

  @Post(path: '/movePiece')
  Future<Response<Either<Failure, Arena>>> movePiece(
    @Field('insect') Map<String, dynamic> insect,
    @Field('newCoordinates') Map<String, dynamic> coordinates,
  );
}
