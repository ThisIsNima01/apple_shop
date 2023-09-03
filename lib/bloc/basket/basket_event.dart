import 'package:apple_shop/data/model/basket_item.dart';

abstract class BasketEvent {}

class BasketFetchFromHiveEvent extends BasketEvent {}

class BasketItemDeleted extends BasketEvent {
  BasketItem basketItem;

  BasketItemDeleted(this.basketItem);
}

class BasketItemAdded extends BasketEvent {
  final BasketItem cartItem;

  BasketItemAdded({required this.cartItem});
}

class BasketPaymentResponseEvent extends BasketEvent {

}

class BasketPaymentRequestEvent extends BasketEvent {

}