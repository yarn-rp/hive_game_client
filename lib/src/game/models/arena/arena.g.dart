// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Arena _$ArenaFromJson(Map<String, dynamic> json) => Arena(
      player1Insects: (json['player1Insects'] as List<dynamic>)
          .map((e) => Insect.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPlayerId: json['currentPlayerId'] as String,
      player2Insects: (json['player2Insects'] as List<dynamic>)
          .map((e) => Insect.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArenaToJson(Arena instance) => <String, dynamic>{
      'player1Insects': instance.player1Insects,
      'player2Insects': instance.player2Insects,
      'currentPlayerId': instance.currentPlayerId,
    };
