import 'dart:ffi';

import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem item);

  Future<List<BasketItem>> getAllBasketItems();

  Future<List<int>> getFinalBasketPrice();

  Future<void> deleteProduct(BasketItem basketItem);

  Future<void> clearBasket();
}

class BasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('basketBox');

  @override
  Future<void> addProduct(BasketItem item) async {
    var items = await getAllBasketItems();
    if (items
        .where((element) => element.isSameItem(item))
        .toList()
        .isNotEmpty) {
      var newItem =
          items.where((element) => element.isSameItem(item)).toList().first;
      newItem.quantity = newItem.quantity + 1;
      newItem.discountPrice = item.discountPrice * newItem.quantity;
      newItem.price = item.price * newItem.quantity;
      newItem.save();
    } else {
      box.add(item);
    }
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<List<int>> getFinalBasketPrice() async {
    var basketList = box.values.toList();
    final mainPrice = basketList.fold(
        0, (previousValue, basketItem) => previousValue + basketItem.price);

    final finalPrice = basketList.fold(
        0,
        (previousValue, basketItem) =>
            previousValue + basketItem.discountPrice);

    final discount = basketList.fold(
        0,
        (previousValue, basketItem) =>
            previousValue + (basketItem.price - basketItem.discountPrice));
    return [mainPrice, discount, finalPrice];
  }

  @override
  Future<void> deleteProduct(BasketItem basketItem) async {
    basketItem.delete();
  }

  @override
  Future<void> clearBasket() async{
    box.clear();
  }
}
