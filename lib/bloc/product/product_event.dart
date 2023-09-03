import 'package:apple_shop/data/model/basket_item.dart';

import '../../data/model/product.dart';

abstract class ProductEvent {

}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializeEvent(this.productId,this.categoryId);
}

class ProductAddedToBasket extends ProductEvent {
  BasketItem product;
  ProductAddedToBasket(this.product);
}