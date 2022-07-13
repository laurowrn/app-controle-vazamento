import 'package:app/app/routes.dart';
import 'package:app/app/services/firebase_messaging_service.dart';
import 'package:app/app/services/notification_service.dart';
import 'package:app/app/views/home_view.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: ((context) => NotificationService()),
        ),
        Provider<FirebaseMessagingService>(
          create: ((context) => FirebaseMessagingService(
                context.read<NotificationService>(),
              )),
        ),
      ],
      child: MaterialApp(
        title: "App",
        home: HomeView(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ).copyWith(
            secondary: Colors.green,
          ),
          fontFamily: "Roboto",
        ),
        routes: Routes.list,
        initialRoute: Routes.initial,
        navigatorKey: Routes.navigatorKey,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
