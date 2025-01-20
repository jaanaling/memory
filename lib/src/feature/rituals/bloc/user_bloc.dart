import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nero/src/core/dependency_injection.dart';
import 'package:nero/src/feature/rituals/model/achievement.dart';
import 'package:nero/src/feature/rituals/model/article.dart';
import 'package:nero/src/feature/rituals/model/user.dart';
import 'package:nero/src/feature/rituals/presentation/game_screen.dart';
import 'package:nero/src/feature/rituals/repository/user_repository.dart';
import 'package:nero/src/feature/rituals/utils/game_logic.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final userRepository = locator<UserRepository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserHintBought>(_onHintBought);
    on<UserHintUsed>(_onHintUsed);
    on<UserPuzzleSolved>(_onPuzzleSolved);
    on<UserAchievementEarned>(_onAchievementEarned);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      final user = await userRepository.load() ?? User.initial;
      final achievements = await userRepository.loadAchievements();
      final articles = await userRepository.loadArticles();

      emit(
        UserLoaded(
          user: user,
          achievements: achievements,
          articles: articles,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  void _onHintBought(UserHintBought event, Emitter<UserState> emit) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;

    final newCoins = current.user.coins - event.cost;
    if (newCoins < 0) return;

    final newHints = current.user.hints + 1;
    final newUser = current.user.copyWith(
      coins: newCoins,
      hints: newHints,
    );

    emit(current.copyWith(user: newUser));
  }

  void _onHintUsed(UserHintUsed event, Emitter<UserState> emit) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;

    if (current.user.hints <= 0) return;

    final newHints = current.user.hints - 1;
    final newHintsUsed = current.user.hintsUsed + 1;
    final newUser = current.user.copyWith(
      hints: newHints,
      hintsUsed: newHintsUsed,
    );

    emit(current.copyWith(user: newUser));
  }

  void _onPuzzleSolved(UserPuzzleSolved event, Emitter<UserState> emit) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;

    final wasCorrect = event.isCorrect;
    final oldUser = current.user;

    final newPuzzlesSolved = oldUser.puzzlesSolved + (wasCorrect ? 1 : 0);
    final newConsecutive =
        wasCorrect ? oldUser.consecutivePuzzlesSolved + 1 : 0;

    final newCoins = wasCorrect ? oldUser.coins + 5 : oldUser.coins;

    final newUser = oldUser.copyWith(
      coins: newCoins,
      puzzlesSolved: newPuzzlesSolved,
      consecutivePuzzlesSolved: newConsecutive,
    );

    emit(current.copyWith(user: newUser));

    if (!wasCorrect) return;

    checkAch(
      oldUser,
      newPuzzlesSolved,
      newUser,
      event,
      newConsecutive,
      newCoins,
    );
  }

  void _onAchievementEarned(
    UserAchievementEarned event,
    Emitter<UserState> emit,
  ) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;
    final oldUser = current.user;

    if (oldUser.achievements.contains(event.achievementId)) return;

    Achievement? achievement;
    try {
      achievement =
          current.achievements.firstWhere((a) => a.id == event.achievementId);
    } catch (_) {
      return;
    }

    final newAchievements = List<int>.from(oldUser.achievements)
      ..add(achievement.id);
    final newCoins = oldUser.coins + achievement.reward;

    final newUser = oldUser.copyWith(
      achievements: newAchievements,
      coins: newCoins,
    );

    emit(current.copyWith(user: newUser));
  }

  void checkAch(
    User oldUser,
    int newPuzzlesSolved,
    User newUser,
    UserPuzzleSolved event,
    int newConsecutive,
    int newCoins,
  ) {
    if (oldUser.puzzlesSolved == 0) {
      add(const UserAchievementEarned(1));
    }

    if (newPuzzlesSolved == 5) {
      add(const UserAchievementEarned(2));
    }

    if (newPuzzlesSolved == 10) {
      add(const UserAchievementEarned(3));
    }

    if (newUser.hintsUsed == 1) {
      add(const UserAchievementEarned(4));
    }

    if (newUser.hintsUsed == 5) {
      add(const UserAchievementEarned(5));
    }

    if (event.difficulty == DifficultyLevel.extreme) {
      add(const UserAchievementEarned(6));
    }

    if (newConsecutive == 3) {
      add(const UserAchievementEarned(7));
    }

    if (newConsecutive == 5) {
      add(const UserAchievementEarned(8));
    }

    if (newCoins >= 100 && oldUser.coins < 100) {
      add(const UserAchievementEarned(9));
    }

    if (newUser.hints >= 10 && oldUser.hints < 10) {
      add(const UserAchievementEarned(10));
    }
  }
}
