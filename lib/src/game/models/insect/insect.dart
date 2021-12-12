import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hive_game_client/src/game/models/models.dart';

class Insect with EquatableMixin {
  final String type;
  final int id;
  final String playerId;
  final Position? position;
  final bool isPlaced;
  final int level;

  factory Insect.fromJson(List json) {
    log('Parsing insect $json');
    final type = json[0];
    final id = json[1];
    final playerId = json[2];
    final position = json[3] == 'none'
        ? null
        : Position(json[3][0] as int, json[3][1] as int);
    final isPlaced = json[4];
    final level = json[5];
    return Insect(
      type,
      id,
      playerId,
      position,
      isPlaced,
      level,
    );
  }

  Insect(
    this.type,
    this.id,
    this.playerId,
    this.position,
    this.isPlaced,
    this.level,
  );
  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [
        type,
        id,
        playerId,
        position,
        isPlaced,
        level,
      ];
}
