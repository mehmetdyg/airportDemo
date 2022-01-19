import '../models/airportIcaoModel.dart';
import 'package:flutter/cupertino.dart';

class AirportIcaoProvider with ChangeNotifier {
  List<AirportIcaoItem> _items = [];
  bool isComplete = false;

  List<AirportIcaoItem> get items {
    return [..._items];
  }

  bool get isCompleted {
    return isComplete;
  }

  void updateAirportIcaoItems(List<AirportIcaoItem> newItemList) {
    _items.clear();
    _items = newItemList;
    isComplete = true;
    notifyListeners();
  }
}
