// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      json['id'] as String,
      json['name'] as String,
      json['movesCount'] as num,
      json['gameOver'] as bool,
      json['hasQueenOnArena'] as bool,
      json['type'] as String,
      (json['insects'] as List<dynamic>)
          .map((e) => Insect.fromJson(e as List<dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'gameOver': instance.gameOver,
      'id': instance.id,
      'insects': instance.insects,
      'name': instance.name,
      'movesCount': instance.numberOfMoves,
      'hasQueenOnArena': instance.queenBeePlaced,
      'type': instance.typePlayer,
    };
