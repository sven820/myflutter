import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ShopCar extends ChangeNotifier {

  List<GoodItem> list = [];
  double total = 0.0;

  isContain(String id) {
    return list.indexWhere((element) => element.id == id) > -1;
  }

  addGood(GoodItem item) {
    list.add(item);
    total += item.price;
    notifyListeners();
  }

  removeGoodAt(int index) {
    var item = list.removeAt(index);
    total -= item.price;
    notifyListeners();
    return item;
  }
  GoodItem? removeGood(String id) {
    GoodItem? i;
    list.removeWhere((element){
      if (element.id == id) {
        total -= element.price;
        i =  element;
        return true;
      }
      return false;
    });
    notifyListeners();
    return i;
  }
  clear() {
    list.clear();
    total = 0;
    notifyListeners();
  }
}


class GoodList {

  List<GoodItem> list = [];

  updateList(List<GoodItem> arr) {
    this.list = arr;
    // notifyListeners();
  }

  clear() {
    this.list = [];
    // notifyListeners();
  }
}


class GoodItem {

  final String id;
  final String name;
  final double price;

  GoodItem(this.id, this.name, this.price);
}