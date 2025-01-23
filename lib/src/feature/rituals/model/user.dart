// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
   int coins; // монеты
   int hints; // подсказки
   List<int> achievements; // список id достижений, которые уже получены
   int puzzlesSolved; // сколько всего загадок решено
   int hintsUsed; // сколько раз использовались подсказки
   int consecutivePuzzlesSolved;
   int record;

   User({
    required this.coins,
    required this.hints,
    required this.achievements,
    required this.puzzlesSolved,
    required this.hintsUsed,
    required this.consecutivePuzzlesSolved,
     required this.record,
  });

  User copyWith({
    int? coins,
    int? hints,
    List<int>? achievements,
    int? puzzlesSolved,
    int? hintsUsed,
    int? consecutivePuzzlesSolved,
    int? record,
  }) {
    return User(
      coins: coins ?? this.coins,
      hints: hints ?? this.hints,
      achievements: achievements ?? this.achievements,
      puzzlesSolved: puzzlesSolved ?? this.puzzlesSolved,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      consecutivePuzzlesSolved:
          consecutivePuzzlesSolved ?? this.consecutivePuzzlesSolved,
          record: record ?? this.record,
    );
  }

  static User get initial =>  User(
        coins: 0,
        hints: 0,
        achievements: [],
        puzzlesSolved: 0,
        hintsUsed: 0,
        consecutivePuzzlesSolved: 0,
        record: 0,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coins': coins,
      'hints': hints,
      'achievements': achievements,
      'puzzlesSolved': puzzlesSolved,
      'hintsUsed': hintsUsed,
      'consecutivePuzzlesSolved': consecutivePuzzlesSolved,
      'record': record,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      coins: map['coins'] as int,
      hints: map['hints'] as int,
      achievements: List<int>.from(map['achievements'] as List<dynamic>),
      puzzlesSolved: map['puzzlesSolved'] as int,
      hintsUsed: map['hintsUsed'] as int,
      consecutivePuzzlesSolved: map['consecutivePuzzlesSolved'] as int,
      record: map['record'] as int,


    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(coins: $coins, hints: $hints, achievements: $achievements, puzzlesSolved: $puzzlesSolved, hintsUsed: $hintsUsed, consecutivePuzzlesSolved: $consecutivePuzzlesSolved)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.coins == coins &&
        other.hints == hints &&
        listEquals(other.achievements, achievements) &&
        other.puzzlesSolved == puzzlesSolved &&
        other.hintsUsed == hintsUsed &&
        other.record == record &&
        other.consecutivePuzzlesSolved == consecutivePuzzlesSolved;

  }

  @override
  int get hashCode {
    return coins.hashCode ^
        hints.hashCode ^
        achievements.hashCode ^
        puzzlesSolved.hashCode ^
        hintsUsed.hashCode ^
        consecutivePuzzlesSolved.hashCode;
  }
}
