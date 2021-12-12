import 'package:json_annotation/json_annotation.dart';

import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/player/player.dart';

part 'arena.g.dart';

@JsonSerializable()
class Arena {
  final Player player1;
  final Player player2;
  final String currentPlayerId;
  final List<Insect> insects;

  Arena({
    required this.currentPlayerId,
    required this.player1,
    required this.player2,
    required this.insects,
  });

  factory Arena.fromJson(Map<String, dynamic> json) => _$ArenaFromJson(json);

  Arena copyWith({
    Player? player1,
    Player? player2,
    String? currentPlayerId,
    List<Insect>? insects,
  }) {
    return Arena(
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      insects: insects ?? this.insects,
    );
  }
}
