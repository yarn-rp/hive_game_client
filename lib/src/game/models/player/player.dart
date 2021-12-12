import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  Player(
    this.id,
    this.name,
    this.numberOfMoves,
    this.gameOver,
    this.queenBeePlaced,
    this.typePlayer,
    this.insects,
  );

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  @JsonKey(name: 'gameOver')
  final bool gameOver;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'insects')
  final List<Insect> insects;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'number_of_moves')
  final num numberOfMoves;

  @JsonKey(name: 'queen_bee_placed')
  final bool queenBeePlaced;

  @JsonKey(name: 'type_player')
  final String typePlayer;
}
