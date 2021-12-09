import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insect.g.dart';

abstract class Insect {
  final String name;
  final Position? position;
  final List<Position> possiblePositions;
  final IconData icon;

  Insect(
    this.name,
    this.position,
    this.possiblePositions,
    this.icon,
  );
  factory Insect.fromJson(Map<String, dynamic> json) {
    return QueenBee.fromJson(json);
  }
  Map<String, dynamic> toJson() => {};
}

@JsonSerializable()
class QueenBee extends Insect {
  QueenBee({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          FontAwesomeIcons.behance,
        );

  factory QueenBee.fromJson(Map<String, dynamic> json) =>
      _$QueenBeeFromJson(json);
}
