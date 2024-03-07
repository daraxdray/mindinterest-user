// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mindintrest_user/core/constants/global.dart';

enum Flavor { prod, dev, stg }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor);

  final Flavor flavor;
  static FlavorConfig? _instance;
  static FlavorConfig? get instance => _instance;

  String get appTitle =>
      _instance!.flavor == Flavor.prod ? 'MindInterest' : '[Dev] MindIntrest';

  String get splashSlug => _instance!.flavor == Flavor.prod ? '' : '_dev';

  bool get isStaging =>
      _instance!.flavor == Flavor.dev || _instance!.flavor == Flavor.stg;
}

class EnvCredentials {
  static String kUrlHost = dotenv.env['URL_HOST'] ?? '';
  static String paystackKey = dotenv.env['PAYSTACK_PUBLIC_KEY'] ?? '';
}
