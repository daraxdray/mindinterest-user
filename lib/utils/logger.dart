// ignore_for_file: noop_primitive_operations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final tmiLogger = Logger(
  printer: SimpleLogPrinter(className: 'TMI'),
);

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter({
    this.className,
  });

  final String? className;

  @override
  List<String> log(LogEvent event, [dynamic error, StackTrace? stackTrace]) {
    /// Don't log if in release mode
    if (kReleaseMode) return [];
  PrettyPrinter pp = new PrettyPrinter();
    final message = stringifyMessage(event.message);
    return [
      if (Platform.isIOS) '$message\n' else '$message\n'
    ];
  }

  String? stringifyMessage(dynamic message) {
    const decoder = JsonDecoder();
    const encoder = JsonEncoder.withIndent('  ');
    final color = AnsiColor.fg(15);

    if (message is String) {
      try {
        if (message.contains(':') == false || message.contains('->')) {
          return message;
        }
        dynamic raw = decoder.convert(message);
        return Platform.isAndroid
            ? color(encoder.convert(raw))
            : encoder.convert(raw);
      } catch (e) {
        return message.toString();
      }
    } else if (message is Map || message is Iterable) {
      return Platform.isAndroid
          ? color(encoder.convert(message))
          : encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
