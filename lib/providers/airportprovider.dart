import 'package:airport_app/models/airportmodel.dart';
import 'package:flutter/cupertino.dart';

class AirportProvider with ChangeNotifier {
  List<Item> _items = [];
  bool isComplete = false;

  List<Item> get items {
    return [..._items];
  }

  bool get isCompleted {
    return isComplete;
  }

  void updateItems(List<Item> newItemList) {
    _items.clear();
    _items = newItemList;
    isComplete = true;
    notifyListeners();
  }
}
