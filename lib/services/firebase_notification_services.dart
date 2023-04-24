import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class FirebaseNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final ValueNotifier<String?> _title = ValueNotifier(null);
  final ValueNotifier<String?> _body = ValueNotifier(null);

  ValueNotifier<String?> get getTitle => _title;
  ValueNotifier<String?> get getBody => _body;

  set setTitle(titleText) {
    _title.value = titleText;
  }

  set setBody(bodyText) {
    _body.value = bodyText;
  }

  Future initialise() async {
    var token = await _fcm.getToken();
    print("FCM token : $token");
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          setTitle = message.notification!.title;
          setBody = message.notification!.body;
        }
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      _handleMessage(message, context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("message recieved");

      _handleMessage(message, context);
    });
  }

  void _handleMessage(RemoteMessage message, BuildContext context) {
    if (message.notification != null) {
      setTitle = message.notification!.title;
      setBody = message.notification!.body;

      
    }
  }
}
