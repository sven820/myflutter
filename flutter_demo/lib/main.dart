
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/shop_cart/index.dart';
import 'app_list.dart';
import 'app_random_words.dart';
import 'app_chat.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:json_serializable/json_serializable.dart';
import 'layout_demo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_package_jxf_demo/flutter_package_jxf_demo.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_plugin_jxf_demo/flutter_plugin_jxf_demo.dart';


void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {


  var calculator = Calculator();

  getPlatformVersion() async {
    var version = await FlutterPluginJxfDemo.platformVersion;
    print("version: $version");
    var level = await FlutterPluginJxfDemo.batteryLevel;
    print("level: $level");
  }

  @override
  Widget build(BuildContext context) {

    getPlatformVersion();

    return MaterialApp(
      title: "appTitle",
      routes: { //路由表
        "/first": (context)=>FirstPage(),
        "/second": (context)=>SecondPage("default"),
        "/image": (context)=>ImagePage(),
      },
      onGenerateRoute: (RouteSettings settings){ //如果路由
        // 表中没有注册，才会调用
        return MaterialPageRoute(builder: (context){
          String? name = settings.name;
          print(name);
          return UndefindPage();
        });
      },
      home: DemoPage(),
    );
  }
}


class BuildRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return streamBuild();
  }

  Widget streamBuild() {
    return StreamBuilder<int>(
      stream: counter(), //
      //initialData: ,// a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('没有Stream');
          case ConnectionState.waiting:
            return Text('等待数据...');
          case ConnectionState.active:
            return Text('active: ${snapshot.data}');
          case ConnectionState.done:
            return Text('Stream已关闭');
        }
      },
    );
  }
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  Widget futureBuide() {
    return Center(
      child: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            // 请求未结束，显示loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }
}

class MyCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "",
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Cupertino Demo"),
        ),
        backgroundColor: Colors.white,
        child: Center(
          child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text("Press"),
              onPressed: () {}
          ),
        ),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }
}
class DemoPageState extends State<DemoPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("count tool"),
      ),
      body: Column(children: [
        Text("times count: $count"),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return FirstPage();
          }));
        }, child: Text("open first page")),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, "/jxf");
        }, child: Text("test onGenerateRoute")),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, "/image", arguments: "resource/images/hefei_guihua");
        }, child: Text("open image")),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
              count++ ;
            });
          }),
    );
  }

}

class UndefindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("undefindPage"),),
      body: Text("404"),
    );
  }

}

class ImagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: Text("image"),),
      body: Center(child: Image.asset(name ?? ""),),
    );
  }

}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("first"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>{},
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50),
      ),
      body: TextButton(
        child: Text("open second"),
        clipBehavior: Clip.hardEdge,
        onPressed: () async {
          var result = await Navigator.pushNamed(context, "/second");
          print(result);
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String text;

  SecondPage(this.text);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("second"),
      ),
      drawer: Drawer(
        child: Center(
          child: Text('抽屉'),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text("back"),
            clipBehavior: Clip.hardEdge,
            onPressed: (){
              Navigator.pop(context, "second back msg");
            },
          ),
          Text(text),
        ],
      ),
    );
  }

}

//构造函数
class Person {
  final String name;

  // Person(this.name, this.age);
  Person({this.name = "jxf"});

  testFunc() {
    var p = Person();
    Echo(text: "jxf");
  }
}

class Echo extends StatelessWidget {
  const Echo({
    Key? key,
    required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}


