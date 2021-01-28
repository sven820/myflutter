import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class AppChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chat",
      home: ChatView(),
    );
  }

}

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
      ),
      body: Text("chat"),
    );
  }
}



