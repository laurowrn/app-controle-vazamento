import 'package:app/app/routes.dart';
import 'package:app/app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
  }

  Future<String?> getDeviceFirebaseToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('TOKEN: $token');
    return token;
  }

  _onMessage() async {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notificationService.showNotification(CustomNotification(
          id: android.hashCode,
          title: notification.title!,
          body: notification.body!,
          payload: message.data['route'] ?? '',
        ));
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAferMessage);
  }

  _goToPageAferMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushReplacementNamed(route);
    }
  }
}
