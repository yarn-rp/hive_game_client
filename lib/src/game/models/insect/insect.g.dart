// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueenBee _$QueenBeeFromJson(Map<String, dynamic> json) => QueenBee(
      name: json['name'] as String,
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      possiblePositions: (json['possiblePositions'] as List<dynamic>)
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueenBeeToJson(QueenBee instance) => <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'possiblePositions': instance.possiblePositions,
    };
