import 'package:flutter/material.dart';
import 'package:flutter_app/shop_cart/goods.dart';
import 'package:flutter_app/shop_cart/login.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MyShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
          providers: [
            Provider(create: (context)=>GoodList()),
            // ChangeNotifierProvider(
            //   create: (context)=>GoodList(),
            // ),
            ChangeNotifierProvider(
              create: (context)=>ShopCar(),
            ),
            ChangeNotifierProxyProvider<GoodList, ShopCar>(
                create: (context)=>ShopCar(),
                update: (context, goodlist, shopcar){
                  print("ChangeNotifierProxyProvider GoodList ShopCar");
                  return shopcar ?? ShopCar();
                },
            )
          ],
          child: MyShopApp(),
        )
    );
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