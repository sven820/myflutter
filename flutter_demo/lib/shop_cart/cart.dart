import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'goods.dart';

class ShopCarController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("shop car"),),
      body: Container(
        color: Colors.yellow,
        child: Column(children: [
          Expanded(child: Padding(padding: EdgeInsets.all(32),child: 
          _ShopCarListView(),)),
          const Divider(height: 4, color: Colors.black,),
          _TotalView()
        ],),
      ),
    );
  }

}

class _TotalView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var hugeStyle =
    Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ShopCar>(builder: (context, model, widget){
              return Text("\$${model.total}", style: hugeStyle,);
            }),
            const SizedBox(width: 24),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopCarListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ShopCarListState();
  }
}
class _ShopCarListState extends State<_ShopCarListView> {

  @override
  Widget build(BuildContext context) {
    var shopCar = context.read<ShopCar>();

    return ListView.builder(
        itemCount: shopCar.list.length,
        itemBuilder: (context, index) {
          
          return ListTile(
            title: Text(shopCar.list[index].name),
            subtitle: Text("\$ ${shopCar.list[index].price}"),
            leading: Icon(Icons.done),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: (){
                setState(() {
                  shopCar.removeGoodAt(index);
                });
              },),
          );
        });
  }

}
