part of 'game_p_vs_ai_bloc.dart';

abstract class GamePVsAiEvent {
  const GamePVsAiEvent();
}

class SetNewInsect extends GamePVsAiEvent {
  final Insect insect;
  final Position position;

  const SetNewInsect(this.insect, this.position);
}

class ChangeInsectPosition extends GamePVsAiEvent {
  final Insect insect;
  final Position position;

  const ChangeInsectPosition(this.insect, this.position);
}
