import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insect.g.dart';

abstract class Insect with EquatableMixin {
  final String name;
  final Position? position;
  final List<Position> possiblePositions;
  final String icon;

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

  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  });

  List<Object?> get props => [name, position, possiblePositions];
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
          'queen_bee',
        );

  factory QueenBee.fromJson(Map<String, dynamic> json) =>
      _$QueenBeeFromJson(json);

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      QueenBee(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}

class Beetle extends Insect {
  Beetle({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          'bettle',
        );

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      Beetle(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}

class Grasshopper extends Insect {
  Grasshopper({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          'grasshopper',
        );

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      Grasshopper(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}

class Spider extends Insect {
  Spider({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          'spider',
        );

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      Spider(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}

class SoldierAnt extends Insect {
  SoldierAnt({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          'ant',
        );

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      SoldierAnt(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}

class LadyBug extends Insect {
  LadyBug({
    required String name,
    required Position? position,
    required List<Position> possiblePositions,
  }) : super(
          name,
          position,
          possiblePositions,
          'lady_bug',
        );

  @override
  Insect copyWith({
    String? name,
    Position? position,
    List<Position>? possiblePositions,
  }) =>
      LadyBug(
        name: name ?? this.name,
        position: position ?? this.position,
        possiblePositions: possiblePositions ?? this.possiblePositions,
      );
}
