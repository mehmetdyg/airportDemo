import 'package:airport_app/models/airportmodel.dart';
import 'package:flutter/cupertino.dart';

class AirportProvider with ChangeNotifier {
  List<Item>? _items = [];

  List<Item> get items {
    return [..._items!];
  }

  void updateItems(List<Item>? newItemList) {
    _items!.clear();
    _items = newItemList;
    notifyListeners();
  }
}
