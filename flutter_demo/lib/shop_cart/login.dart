import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/shop_cart/catalog.dart';
import 'package:flutter_app/shop_cart/goods.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:toast/toast.dart';

class Login extends StatelessWidget {

  String? name;
  String? pwd;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("welcome", style: Theme.of(context).textTheme.headline1,),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(hintText: "input name"),
                onChanged: (text) {
                  name = text;
                },
              ),
              TextFormField(
                initialValue: pwd,
                decoration: InputDecoration(hintText: "input pwd"),
                obscureText: true,
                onChanged: (text) {
                  pwd = text;
                },
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                var check = (name != null && name!.isNotEmpty);
                // Toast.show("msg", context, duration: 2, gravity: 0);
                if (!check) {
                  showToast("please input name", context: context);
                  // Fluttertoast.showToast(msg: "please input name");
                  return;
                }
                check = (pwd != null && pwd!.isNotEmpty);
                if (!check) {
                  showToast("please input pwd");
                  // Fluttertoast.showToast(msg: "please input pwd");
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return GoodsShop();
                }));
              },child: Text("enter"),)
            ],
          ),
        ),
      ),
    );
  }

}