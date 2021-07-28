import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_jxf_demo/flutter_plugin_jxf_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _platformVersion = 'Unknown';
  double _batteryLevel = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    double level;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterPluginJxfDemo.platformVersion ?? 'Unknown platform version';
      level = await FlutterPluginJxfDemo.batteryLevel ?? -1;
    } on PlatformException {
      level = -1;
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    var battery = _batteryLevel >= 0 ? "${_batteryLevel*100}%" : "unknown";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
          Center(
            child: Text('battery level: $battery\n'),
          )
        ],),
      ),
    );
  }
}
