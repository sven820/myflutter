import 'package:flutter/material.dart';
import 'package:flutter_app/shop_cart/login.dart';
import 'package:oktoast/oktoast.dart';

class MyShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(child: MyShopApp());
    // return MyShopApp();
  }
}

class MyShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "shop",
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'Corben',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black
              )
          )
      ),
      home: Login(),
    );
  }

}