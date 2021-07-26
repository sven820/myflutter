import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shop_cart/goods.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hud/flutter_hud.dart';

import 'cart.dart';

class GoodsShop extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return GoodsShopState();
  }
}

class GoodsShopState extends State<GoodsShop> {

  bool loading = false;
  GoodList? goodList;

  @override
  void initState() {
    super.initState();
  }

  requestGoodsListWithHud() async{ //hud不能在state 周期里面执行

    var hud = PopupHUD(context);
    hud.show();
    try {
      var model = await Future.delayed(Duration(seconds: 2), (){
        var a = GoodList();
        a.list.add(GoodItem("1", "apple", 5));
        a.list.add(GoodItem("2", "iphone", 9998));
        print(a.list.length);
        return a;
      });
      // Provider.of<GoodList>(this.context, listen: true).updateList(model.list);
      // this.context.watch<GoodList>().updateList(model.list);
      hud.dismiss();
      goodList = model;
      if (mounted) {
        setState(() {
          this.context.read<GoodList>().updateList(model.list);
        });
      }
    }catch (e) {
      hud.dismiss();
      showToast(e.toString(), context: context);
      print(e);
    }
  }

  requestGoodsList() async{

    try {
      var model = await Future.delayed(Duration(seconds: 2), (){
        var a = GoodList();
        a.list.add(GoodItem("1", "apple", 5));
        a.list.add(GoodItem("2", "iphone", 9998));
        print(a.list.length);
        return a;
      });
      // Provider.of<GoodList>(this.context, listen: true).updateList(model.list);
      // this.context.watch<GoodList>().updateList(model.list);
      goodList = model;
      if (mounted) {
        setState(() {
          this.context.read<GoodList>().updateList(model.list);
        });
      }
    }catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    var listModel = this.context.read<GoodList>();
    var sc = Scaffold(
      appBar: AppBar(
        title: Text("商品"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopCarController()));
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.refresh), onPressed: requestGoodsListWithHud,),
      body: ListView.builder(
        itemCount: listModel.list.length,
        itemBuilder: (item, index)=>Consumer<ShopCar>(builder: (context, model,
            widget){
          return _GoodListCell(index: index,);
        }),
      ),
    );

    // var hud = ModalProgressHUD(inAsyncCall: goodList == null, child: sc);
    var hud = WidgetHUD(
        showHUD: goodList == null,
        builder: (context){
          return sc;
    });
    
    var back = WillPopScope(child: hud, onWillPop: ()async{
      this.context.read<GoodList>().clear();
      return true;
    });

    if (goodList == null) {
      requestGoodsList();
    }

    return back;
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive ${this.context}");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose ${this.context}");
  }

  @override
  void didUpdateWidget(GoodsShop oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class GoodsShop2 extends StatelessWidget {

  GoodList? listModel;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<GoodList>(
        future: requestForGoodsList(),
        builder: (context, model) {

          this.listModel = model.data;
          return WidgetHUD(
              showHUD: !model.hasData,
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: Text("商品"),),
                  body: ListView.builder(
                    itemCount: listModel?.list.length ?? 0,
                    itemBuilder: (item, index)=>getListRow(index),
                  ),
                );
              });
        }
    );
  }

  Widget getListRow(int index) {

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48),
      child: Row(children: [
        const SizedBox(width: 12,),
        SizedBox(width: 40, height: 40, child: Container(color: Colors
            .orange,),),
        const SizedBox(width: 24,),
        Expanded(child: Text(listModel?.list[index].name ?? "")),
        const SizedBox(width: 24,),
        _ShopAddButton((){

        }, "+"),
      ],),
    );
  }

  Future<GoodList> requestForGoodsList() async{
    var model = await Future.delayed(Duration(seconds: 2), (){
      var a = GoodList();
      a.list.add(GoodItem("1", "apple", 5));
      a.list.add(GoodItem("2", "iphone", 9998));
      print(a.list.length);
      return a;
    });
    return model;
  }
}

class _GoodListCell extends StatefulWidget {

  final int index;
  _GoodListCell({this.index = 0});

  @override
  State<StatefulWidget> createState() {
    return _GoodListCellState();
  }
}
class _GoodListCellState extends State<_GoodListCell> {

  get index => widget.index;

  @override
  Widget build(BuildContext context) {

    var listModel = context.read<GoodList>();
    var item = listModel.list[index];
    var isAdded = context.read<ShopCar>().isContain(item.id);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48),
      child: Row(children: [
        const SizedBox(width: 12,),
        SizedBox(width: 40, height: 40, child: Container(color: Colors
            .orange,),),
        const SizedBox(width: 24,),
        Text(listModel.list[index].name),
        const SizedBox(width: 24,),
        Text("\$${listModel.list[index].price}"),
        Expanded(child: SizedBox(width: 24,)),
        _ShopAddButton((){
          if (isAdded) {
            context.read<ShopCar>().removeGood(item.id);
          }else {
            context.read<ShopCar>().addGood(item);
          }
          setState(() {});
        }, isAdded ? "-": "+"),
      ],),
    );
  }

}


class _ShopAddButton extends StatelessWidget {

  VoidCallback clickHandle;
  String dot;

  _ShopAddButton(this.clickHandle, this.dot);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        clickHandle();
      },
      child: Text(dot, style: TextStyle(fontSize: 30, fontWeight: FontWeight
          .bold),),
    );
  }

}