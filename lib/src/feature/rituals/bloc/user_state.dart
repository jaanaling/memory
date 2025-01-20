part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;
  final List<Achievement> achievements;
  final List<Article> articles;

  const UserLoaded({
    required this.user,
    required this.achievements,
    required this.articles,
  });

  UserLoaded copyWith({
    User? user,
    List<Achievement>? achievements,
    List<Article>? articles,
  }) {
    return UserLoaded(
      user: user ?? this.user,
      achievements: achievements ?? this.achievements,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [user, achievements, articles];
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
