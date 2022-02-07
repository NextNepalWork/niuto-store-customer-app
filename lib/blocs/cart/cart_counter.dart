import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_kundol/models/products/product.dart';

class CartCounter with ChangeNotifier {
  List<int> productIdList = [];
  List<int> get count => productIdList;
  increment({Product product}) {
    if (productIdList.contains(product.productId)) {
    } else {
      productIdList.add(product.productId);
    }

    notifyListeners();
  }

  void decrement({Product product}) {
    productIdList.remove(product.productId);
    notifyListeners();
  }
}
