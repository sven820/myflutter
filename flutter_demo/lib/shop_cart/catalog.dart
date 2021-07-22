import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shop_cart/goods.dart';

class GoodsShop extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {

    return GoodsShopState();
  }
}

class GoodsShopState extends State<GoodsShop> {

  GoodList? listModel;

  @override
  void initState() {
    super.initState();

    getGoodsList();

  }

  getGoodsList() async{

    try {
      var model = await Future.delayed(Duration(seconds: 2), (){
        var a = GoodList();
        a.list.add(GoodItem("1", "apple", 5));
        a.list.add(GoodItem("2", "iphone", 9998));
        print(a.list.length);
        return a;
      });
      setState(() {
        this.listModel = model;
      });
    }catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("商品"),),
      body: ListView.builder(
        itemCount: listModel?.list.length ?? 0,
        itemBuilder: (item, index){
            return getListRow(index);
        },
      ),
    );
  }

  Widget getListRow(int index) {

    var item = listModel?.list[index];
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48),
      child: Row(children: [
        const SizedBox(width: 12,),
        SizedBox(width: 40, height: 40, child: Container(color: Colors
            .orange,),),
        const SizedBox(width: 24,),
        Expanded(child: Text(listModel?.list[index].name ?? "")),
        const SizedBox(width: 24,),
        _ShopAddButton(),
      ],),
    );
  }
}

class _ShopAddButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){},
      child: Text("+", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
    );
  }

}