import 'package:chopper/chopper.dart';
import 'package:hive_game_client/src/game/api/hive_game_service.dart';
import 'package:hive_game_client/src/game/repository/game_repository.dart';
import 'package:hive_game_client/src/game/state_management/player_vs_player_bloc/game_bloc.dart';

import 'package:get_it/get_it.dart';

Future<void> initGame(
  GetIt sl, {
  required String apiBaseUrl,
  required int appVersion,
}) async {
  sl
    ..registerFactoryParam<GamePvsPBloc, String, String>(
      (player1, player2) {
        final _repo = sl<GameRepository>();
        return GamePvsPBloc(
          player1,
          player2,
          _repo,
        );
      },
    )
    ..registerLazySingleton(
      () {
        return GameRepository(
            sl<ChopperClient>().getService<HiveGameService>());
      },
    );
}
