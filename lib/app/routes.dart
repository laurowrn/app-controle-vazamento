import 'package:app/app/views/consumption_view.dart';
import 'package:app/app/views/control_view.dart';
import 'package:app/app/views/home_view.dart';
import 'package:app/app/views/settings_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => HomeView(),
    '/control': (_) => ControlView(),
    '/consumption': (_) => ConsumptionView(),
    '/settings': (_) => SettingsView(),
  };

  static String initial = '/home';
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
