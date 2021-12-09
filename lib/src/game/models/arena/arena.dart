import 'package:hive_game_client/src/game/models/insect/insect.dart';

import 'package:json_annotation/json_annotation.dart';
part 'arena.g.dart';

@JsonSerializable()
class Arena {
  final List<Insect> player1Insects;
  final List<Insect> player2Insects;
  final String currentPlayerId;

  Arena({
    required this.player1Insects,
    required this.currentPlayerId,
    required this.player2Insects,
  });

  factory Arena.fromJson(Map<String, dynamic> json) => _$ArenaFromJson(json);
}
