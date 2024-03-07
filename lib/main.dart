import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mindintrest_user/app/app.dart';
import 'package:mindintrest_user/app/flavor_config.dart';
import 'package:mindintrest_user/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindintrest_user/core/services/notification/fcm.dart';
import 'package:mindintrest_user/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: '.env.dev',
  );

  FlavorConfig(flavor: Flavor.dev);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.initialize();

  bootstrapApp(const App());
}




