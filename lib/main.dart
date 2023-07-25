import 'dart:io';

import 'package:arbocanoas/res/owner_colors.dart';
import 'package:arbocanoas/ui/navigation/map/map_sample.dart';
import 'package:arbocanoas/ui/navigation/intro/splash.dart';
import 'package:arbocanoas/ui/navigation/notifications/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/notification_helper.dart';
import 'config/preferences.dart';
import 'config/useful.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotification.showNotification(message);
  print("Handling a background message: $message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  } else if (Platform.isIOS){
    await Firebase.initializeApp(
      /*options: FirebaseOptions(
      apiKey: WSConstants.API_KEY,
      appId: WSConstants.APP_ID,
      messagingSenderId: WSConstants.MESSGING_SENDER_ID,
      projectId: WSConstants.PROJECT_ID,
    )*/);
  }

  LocalNotification.initialize();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
    print('Mensagem recebida: ${message.data}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Mensagem abertaaaaaaaaa: ${message.data}');

  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Useful().getMaterialColor(OwnerColors.colorPrimary),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Useful().getMaterialColor(OwnerColors.colorPrimary)),
    ),
    debugShowCheckedModeBanner: false,
    title: "Arbo Canoas",
    initialRoute: '/ui/splash',
    color: OwnerColors.colorPrimary,
    routes: {
      '/ui/splash': (context) => Splash(),
      '/ui/maps': (context) => MapSample(),
      '/ui/notifications': (context) => Notifications(),
    },
  ));
}
