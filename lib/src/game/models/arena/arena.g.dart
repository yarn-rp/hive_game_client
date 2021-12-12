// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Arena _$ArenaFromJson(Map<String, dynamic> json) => Arena(
      currentPlayerId: json['currentPlayerId'] as String,
      player1: Player.fromJson(json['player1'] as Map<String, dynamic>),
      player2: Player.fromJson(json['player2'] as Map<String, dynamic>),
      insects: (json['insects'] as List<dynamic>)
          .map((e) => Insect.fromJson(e as List<dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArenaToJson(Arena instance) => <String, dynamic>{
      'player1': instance.player1,
      'player2': instance.player2,
      'currentPlayerId': instance.currentPlayerId,
      'insects': instance.insects,
    };
