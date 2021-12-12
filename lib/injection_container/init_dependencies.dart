import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive_game_client/injection_container/external/init_external.dart';
import 'package:hive_game_client/injection_container/src/auth_game.dart';

FutureOr<void> initDependencies(
  GetIt sl, {
  String apiBaseUrl = 'http://localhost:3031',
  int appVersion = 1,
}) async {
  await initExternal(sl, apiBaseUrl: apiBaseUrl, appVersion: appVersion);
  await initGame(sl, apiBaseUrl: apiBaseUrl, appVersion: appVersion);
}
