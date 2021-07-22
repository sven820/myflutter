
class ShopCar {

  List<GoodItem> list = [];
  double total = 0.0;
}


class GoodList {

  List<GoodItem> list = [];

}


class GoodItem {

  final String id;
  final String name;
  final double price;

  GoodItem(this.id, this.name, this.price);
}