import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/pages/Apoteker/PasienProfile.dart';
import 'package:farmasi/pages/Apoteker/ProfileProvider.dart';
import 'package:farmasi/pages/Pasien/HomePasien.dart';
import 'package:farmasi/pages/Apoteker/Input_Obat.dart';
import 'package:farmasi/pages/Pasien/HomeProvider.dart';
import 'package:farmasi/pages/Pasien/JadwalProvider.dart';
import 'package:farmasi/pages/shared/Loading.dart';
import 'package:farmasi/pages/shared/Login.dart';
import 'package:farmasi/pages/Pasien/Jadwal.dart';
import 'package:farmasi/pages/Apoteker/ApotekerProvider.dart';
import 'package:farmasi/pages/shared/Register_Pasien.dart';
import 'package:farmasi/pages/shared/wrapper.dart';
import 'package:farmasi/service/Auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

const bool kIsWeb = identical(0, 0.0);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      //'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(const MyApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xffBB86FC),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                playSound: true,
                importance: Importance.high,
                color: Colors.white,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'ic_launcher',
                timeoutAfter: 7200000),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(context, '/JadwalProvider');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/HomePasien': (context) => HomePasien(),
          '/HomeProvider': (context) => HomeProvider(),
          '/Jadwal': (context) => JadwalScreen(),
          '/Wrapper': (context) => Wrapper(),
          '/ApotekerProvider': (context) => ApotekerProvider(),
          '/Loading': (context) => Loading(),
          '/InputObat': (context) => Input_Obat(),
          '/RegistrasiPasien': (context) => RegisterPasien(),
          '/ProfilePasien': (context) => ProfilePasien(),
          '/ProfileProvider': (context) => ProfileProvider(),
          '/JadwalProvider': (context) => JadwalProvider(),
        },
        theme: ThemeData(
          colorScheme: defaultColorScheme,
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
