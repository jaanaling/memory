import 'package:get_it/get_it.dart';
import 'package:nero/src/feature/rituals/repository/user_repository.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => UserRepository());
}
