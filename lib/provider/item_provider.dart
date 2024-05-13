import 'package:flutter/foundation.dart';

import '../database/model/item.dart';

class ItemProvider extends ChangeNotifier {
  Item? item;
  updateItem(Item item){
    this.item = item;
    notifyListeners();
  }
}