import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "app",
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomListState();
  }
}

class RandomListState extends State<RandomWords> {
  final list = <WordPair>[];
  final saved = Set<WordPair>();
  final style = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _menuPressed)
        ],
      ),
      body: buildList(),
    );
  }
  void _menuPressed() {
    final Iterable<ListTile> tiles = saved.map(
          (WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: style,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile
        .divideTiles(
      context: context,
      tiles: tiles,
    )
        .toList();
    Navigator.of(context).push(new MaterialPageRoute(builder: (contfext){
      return new Scaffold(
        appBar: AppBar(
          title: Text("favorite"),
        ),
        body: new ListView(children: divided,),
      );
    }));

  }

  Widget buildList() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }
        final i = index ~/ 2;
        if (i >= list.length) {
          list.addAll(generateWordPairs().take(10));
        }
        return buildRow(index, list[i]);
      },
    );
  }
  Widget buildRow(int index, WordPair pair) {
    final bool isSaved = saved.contains(pair);
    return ListTile(
      title: Text("$index, ${pair.asPascalCase}", style: style),
      trailing: Icon(isSaved ? Icons.favorite : Icons.favorite_border, color:
      isSaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (isSaved) {
            saved.remove(pair);
          }else {
            saved.add(pair);
          }
        });
      },
    );
  }
}


class RandomState extends State<RandomWords> {

  @override
  Widget build(BuildContext context) {
    var wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }

}