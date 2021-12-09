part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class SetNewInsect extends GameEvent {
  final Insect insect;
  final Position position;

  SetNewInsect(this.insect, this.position);
}

class ChangeInsectPosition extends GameEvent {
  final Insect insect;
  final Position position;

  ChangeInsectPosition(this.insect, this.position);
}
