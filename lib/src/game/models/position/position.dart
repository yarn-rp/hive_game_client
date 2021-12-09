import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position with EquatableMixin {
  final int x;
  final int y;

  Position(this.x, this.y);
  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  @override
  List<Object?> get props => [x, y];
}
