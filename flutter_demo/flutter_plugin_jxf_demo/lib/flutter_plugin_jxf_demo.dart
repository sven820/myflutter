
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginJxfDemo {
  static const MethodChannel _channel = MethodChannel('flutter_plugin_jxf_demo');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<double?> get batteryLevel async {
    final double? level = await _channel.invokeMethod('getBatteryLevel');
    return level;
  }
}
