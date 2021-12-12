import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_game_client/injection_container/init_dependencies.dart';

import 'src/app.dart';

final sl = GetIt.instance;
void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.

  await initDependencies(sl);
  runApp(const MyApp());
}
