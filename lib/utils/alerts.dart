import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class TMIAlerts {
  static void showInfo(BuildContext context, {String? message}) {
    Flushbar<void>(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      borderRadius: BorderRadius.circular(8),
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: kPrimaryColor,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.shade200,
          offset: const Offset(0, 2),
          blurRadius: 3,
        )
      ],
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  static void showError(BuildContext context, {String? message}) {
    Flushbar<void>(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      borderRadius: BorderRadius.circular(8),
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.shade200,
          offset: const Offset(0, 2),
          blurRadius: 3,
        )
      ],
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  static void showSuccess(BuildContext context, {String? message}) {
    Flushbar<void>(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      borderRadius: BorderRadius.circular(8),
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.green,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.shade200,
          offset: const Offset(0, 2),
          blurRadius: 3,
        )
      ],
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
