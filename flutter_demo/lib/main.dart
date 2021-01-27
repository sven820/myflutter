import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'app_list.dart';
import 'app_random_words.dart';

void main() {

  // runApp(MyApp());
  runApp(MaterialApp(
    title: "demo",
    home: Scaffold(
      appBar: AppBar(
        title: Text("demo"),
      ),
      body: Text("hello"),
    ),
  ));
}

Iterable<String> getEmoji(int count) sync* {
  const oneSecond = Duration(seconds: 1);
  Runes first = Runes('\u{1f47f}');
  for (int i = 0; i < count; i++) {
    Future.delayed(oneSecond);
    yield String.fromCharCodes(first.map((e) => e + i));
  }
}



