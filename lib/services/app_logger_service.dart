import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLoggerService {
  void log(String message) {
    final logMsg = '[AppLogger] $message';
    if (kDebugMode) {
      print(logMsg);
    }
    developer.log(logMsg);
  }
}
