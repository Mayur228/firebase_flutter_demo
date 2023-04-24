import 'package:firebase_demo_flutter/services/firebase_notification_services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseNotificationService());
}