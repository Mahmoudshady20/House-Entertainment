import 'package:flutter/foundation.dart';
import 'package:houseenterainment/database/model/categories.dart';

class CategoryProvider extends ChangeNotifier {
  Categories? categories;
  updateCategory(Categories categories){
    this.categories = categories;
    notifyListeners();
  }
}