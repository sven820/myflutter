import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart';

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class AppChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chat",
      theme: defaultTargetPlatform == TargetPlatform.iOS         //new
          ? kIOSTheme                                              //new
          : kDefaultTheme,
      home: ChatView(),
    );
  }

}

class ChatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatViewState();
  }

}

class ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  final textField = TextEditingController();
  final messages = <ChatMessageRow>[];
  var _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
        elevation:
        Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Column(
        children: [
          Flexible(child: ListView.builder(
            padding: EdgeInsets.all(8),
            reverse: true,
            itemBuilder: (_, int index)=>messages[index],
            itemCount: messages.length,
          )),
          Divider(height: 1.0,),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildInputWidget(),
          )
        ],
      ),
    );
  }

  Widget _buildInputWidget() {
    final child = Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(child: TextField(
            controller: textField,
            onSubmitted: _textFieldOnSubmit,
            onChanged: (String str){
              setState(() {
                _isEditing = str.length > 0;
              });
            },
            decoration: InputDecoration.collapsed(hintText: "please input message"),
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: _isEditing ? _onMessageSendClick : null),
          )
        ],
      ),
    );
    final theme = IconThemeData(color: Theme.of(context).accentColor);
    return IconTheme(data: theme, child: child);
  }

  void _onMessageSendClick() {
    _sendMsg(textField.text);
  }

  void _textFieldOnSubmit(String text) {
    _sendMsg(textField.text);
  }

  void _sendMsg(String msg) {
    setState(() {
      _isEditing = msg.length > 0;
    });
    if (msg.length <= 0 ) {
      return;
    }
    print(textField.text);
    textField.clear();
    final row = ChatMessageRow(msg, AnimationController(duration: Duration
      (milliseconds: 700), vsync: this));
    setState(() {
      messages.insert(0, row);
    });
    row.animate.forward();
  }

  @override
  void dispose() {
    for(ChatMessageRow msg in messages) {
      msg.animate.dispose();
    }
    super.dispose();
  }
}

class ChatMessageRow extends StatelessWidget {
  final _msg;
  final _userName = "jxf";
  final animate;
  
  ChatMessageRow(this._msg, this.animate);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(child: Text(_userName[0])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_userName, style: Theme.of(context).textTheme.subtitle1,),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(_msg),
              )
            ],
          )
        ],
      ),
    );
    final curve = SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animate,
            curve: Curves.easeOut
        ),
        axisAlignment:0.0,
        child: container);

    return curve;
  }

}


