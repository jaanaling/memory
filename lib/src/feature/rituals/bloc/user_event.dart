part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class UserHintBought extends UserEvent {
  final int cost;

  const UserHintBought(this.cost);

  @override
  List<Object> get props => [cost];
}

class UserHintUsed extends UserEvent {
  const UserHintUsed();
}

class UserPuzzleSolved extends UserEvent {
  final bool isCorrect;
  final DifficultyLevel difficulty;

  const UserPuzzleSolved({required this.isCorrect, required this.difficulty});

  @override
  List<Object> get props => [isCorrect, difficulty];
}

class UserAchievementEarned extends UserEvent {
  final int achievementId;

  const UserAchievementEarned(this.achievementId);

  @override
  List<Object> get props => [achievementId];
}
class UserLoadData extends UserEvent {
  const UserLoadData();
}
