import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/route/app_router.dart';
import 'package:mindintrest_user/utils/logger.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  if (message != null) {
    show(message);
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'schedule_notification_id', // id
  'Schedule/Bookings notifications', // title
  importance: Importance.high,
  description: 'Receive updates about your bookings',
  enableVibration: true,
  playSound: true,
);

Future<void> show(RemoteMessage? message) async {
  if (message != null) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title ?? "",
          notification.body ?? "",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: null,
            ),
          ),
          payload: jsonEncode(message.data));
    }
  }
}

/// Initalize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

final DarwinInitializationSettings initializationSettingsIOS =
DarwinInitializationSettings();
final DarwinInitializationSettings initializationSettingsMacOS =
DarwinInitializationSettings();
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS);

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static void configureFirebaseNotificationListeners() {
    _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        provisional: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      tmiLogger.d(message);
      var data = message.data;

      if (data['message_kind'].toString().toLowerCase() == 'rating') {
        handleData(data);
      } else {
        show(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      await Firebase.initializeApp();
      tmiLogger.d(message);

      var data = message?.data;

      if (data != null) {
        handleData(data);
      }
    });
  }

  static Future<void> initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);

    configureFirebaseNotificationListeners();

    FirebaseMessaging.instance.onTokenRefresh.listen(_saveTokenInRemoteServer);
  }

  static void selectNotification(NotificationResponse? payload) async {
    if (payload != null) {
      var data = jsonDecode("${payload.payload}");
      handleData(Map.from(data));
    }
  }

  static void handleInitialMessage() async {
    RemoteMessage? msg = await _firebaseMessaging.getInitialMessage();
    var data = msg?.data;

    if (data != null) {
      handleData(data);
    }
  }

  static void handleData(Map data, [bool isAppOpen = false]) {
    tmiLogger.d(data);
    switch (data['message_kind']) {
      case "rating":
        int? cid = int.tryParse(data['consultant_id']);
        String bookingId = data['booking_id'];
        AppRouter.router
            .push(RoutePaths.rateSession + "?cid=$cid&bid=$bookingId");
        break;
      case "schedule_started":
        int? cid = int.tryParse(data['consultant_id']);
        String bookingId = data['booking_id'];
        AppRouter.router
            .push(RoutePaths.conversationScreen + "?cid=$cid&bid=$bookingId");
    }
  }

  static Future<String> getDeviceToken() async {
    String? id = await _firebaseMessaging.getToken();
    return id!;
  }

  static void _saveTokenInRemoteServer(String token) {
//TODO: upload to server;
  }
}
