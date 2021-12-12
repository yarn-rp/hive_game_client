part of 'game_bloc.dart';

@immutable
abstract class GamePvsPEvent {}

class SetNewInsect extends GamePvsPEvent {
  final Insect insect;
  final Position position;

  SetNewInsect(this.insect, this.position);
}

class ChangeInsectPosition extends GamePvsPEvent {
  final Insect insect;
  final int level;
  final Position position;

  ChangeInsectPosition(this.insect, this.position, this.level);
}

class NewGame extends GamePvsPEvent {
  final String player1;
  final String player2;

  NewGame(this.player1, this.player2);
}

class GetPossiblePlacements extends GamePvsPEvent {
  final Insect insect;

  GetPossiblePlacements(this.insect);
}

class GetPossibleMovements extends GamePvsPEvent {
  final Insect insect;
  final Position position;

  GetPossibleMovements(this.insect, this.position);
}
