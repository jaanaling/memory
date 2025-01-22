import 'package:nero/src/feature/rituals/model/user.dart';

import '../../../core/utils/json_loader.dart';

import '../model/article.dart';
import '../model/achievement.dart';

class UserRepository {
  final String key = 'user';

  Future<User?> load() async {
    final users = await JsonLoader.loadData<User>(
      key,
      'assets/json/$key.json', // путь к json с пользователем
      (json) => User.fromMap(json),
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  Future<void> update(User updated) async {
    return JsonLoader.modifyDataList<User>(
      key,
      updated,
      () async {
        final user = await load();
        return user != null ? [user] : [];
      },
      (item) => item.toMap(),
      (itemList) async {
        if (itemList.isNotEmpty) {
          itemList[0] = updated;
        } else {
          itemList.add(updated);
        }
      },
    );
  }

  Future<void> save(User item) {
    return JsonLoader.saveAllData<User>(
      key,
      [item],
      (item) => item.toMap(),
    );
  }

  Future<void> addAchievement(User user, int achievement) async {
    user.achievements.add(achievement);
    await update(user);
  }

  Future<void> addCoins(User user, int amount) async {
    user.coins += amount;
    await update(user);
  }

  Future<void> useHint(User user) async {
    if (user.hints > 0) {
      user.hints -= 1;
      await update(user);
    }
  }

  Future<List<Article>> loadArticles() async {
    // Загрузка статей из JSON файла
    final articles = await JsonLoader.loadData<Article>(
      'article',
      'assets/json/article.json',
      (json) => Article.fromMap(json),
    );
    return articles;
  }

  Future<List<Achievement>> loadAchievements() async {
    // Загрузка достижений из JSON файла
    final achievements = await JsonLoader.loadData<Achievement>(
      'achievement',
      'assets/json/achievement.json',
      (json) => Achievement.fromMap(json),
    );
    return achievements;
  }
}
