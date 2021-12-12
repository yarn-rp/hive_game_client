part of 'game_p_vs_ai_bloc.dart';

abstract class GamePVsAiEvent {}

class SetNewInsect extends GamePVsAiEvent {
  final Insect insect;
  final Position position;

  SetNewInsect(this.insect, this.position);
}

class ChangeInsectPosition extends GamePVsAiEvent {
  final Insect insect;
  final int level;
  final Position position;

  ChangeInsectPosition(this.insect, this.position, this.level);
}

class NewGame extends GamePVsAiEvent {
  final String player1;

  NewGame(this.player1);
}

class GetPossiblePlacements extends GamePVsAiEvent {
  final Insect insect;

  GetPossiblePlacements(this.insect);
}

class GetPossibleMovements extends GamePVsAiEvent {
  final Insect insect;
  final Position position;

  GetPossibleMovements(this.insect, this.position);
}
