// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      json['id'] as String,
      json['name'] as String,
      json['number_of_moves'] as num,
      json['gameOver'] as bool,
      json['queen_bee_placed'] as bool,
      json['type_player'] as String,
      (json['insects'] as List<dynamic>)
          .map((e) => Insect.fromJson(e as List<dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'gameOver': instance.gameOver,
      'id': instance.id,
      'insects': instance.insects,
      'name': instance.name,
      'number_of_moves': instance.numberOfMoves,
      'queen_bee_placed': instance.queenBeePlaced,
      'type_player': instance.typePlayer,
    };
