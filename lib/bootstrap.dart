import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void bootstrapApp(Widget app) {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(ProviderScope(child: app)),
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
