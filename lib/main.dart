import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:ventimetriappclienti/router.dart';
import 'package:ventimetriappclienti/state_managment/state_managment.dart';
import 'package:ventimetriappclienti/theme/colors.dart';
import 'auth/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AwesomeNotifications().initialize(
      null, [
    NotificationChannel(
        channelGroupKey: 'channel_20m2_group_key',
        channelKey: 'channel_20m2_key',
        channelName: 'channel_20m2_name',
        channelDescription: 'channel_20m2 desc default')
  ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'channel_20m2_group_key',
            channelGroupName: 'basic channel group name')
      ]);

  await initNotifications();


  bool isAllowedToReceiveNotification
  = await AwesomeNotifications().isNotificationAllowed();


  if(isAllowedToReceiveNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  initializeDateFormatting().then((value) => runApp(App20m2Clienti()));
}


Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification!.title}");
  print("Handling a background message: ${message.notification!.body}");
}

initNotifications() async {
  try {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();

    final fMCToken = await firebaseMessaging.getToken();
    print('Token: $fMCToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

  } catch (e) {
    print('Error getting FCM token: $e');
    // Handle the error gracefully, e.g., show a message to the user or retry later.
  }
}


Future<void> handleBackgroundMessages(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}


class App20m2Clienti extends StatelessWidget {
  App20m2Clienti({super.key});

  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("User tapped on notification when the app was in the background: ${message.notification!.title}");
      print("User tapped on notification when the app was in the background: ${message.notification!.body}");

      // Handle the notification when the app is opened from background
    });

    return ChangeNotifierProvider(
      create: (context) => StateManagmentProvider(),
      child: MaterialApp(
        routes: Routes.routes,
        home: LandingPage(),
        locale: const Locale('it', 'IT'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('it', 'IT'),
          Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        title: '20m2 Gestione',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: white),
          useMaterial3: true,
        ),
      ),
    );
  }
}



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
    _animationController?.forward().then((value) => Timer(Duration(seconds: 1), _goToLogin));

  }


  void _goToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: brown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: _animation!,
              child: Container(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset('assets/images/logo-bianco.svg')
              ),
            ),
          )
        ],
      ),
    );
  }
}
