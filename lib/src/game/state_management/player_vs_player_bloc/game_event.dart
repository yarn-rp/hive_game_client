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
  final Position position;

  ChangeInsectPosition(this.insect, this.position);
}
