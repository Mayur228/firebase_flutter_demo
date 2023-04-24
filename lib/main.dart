import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_flutter/di/injectable.dart';
import 'package:firebase_demo_flutter/login_page/login_page.dart';
import 'package:firebase_demo_flutter/services/firebase_notification_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  configureDependencies();
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    final FirebaseNotificationService pushNotificationService =
        getIt<FirebaseNotificationService>();
    pushNotificationService.initialise();
    pushNotificationService.setupInteractedMessage(context);
    return Builder(
      builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        );
      }
    );
  }
}
