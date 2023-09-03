import 'package:dartz/dartz.dart';

import '../../data/model/basket_item.dart';
import '../../data/model/transaction.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  List<int> basketSummary;
  bool isPaymentLoading;

  BasketDataFetchedState(this.basketItemList, this.basketSummary,this.isPaymentLoading);
}

class TransactionResponseState extends BasketState {
  Transaction transaction;
  TransactionResponseState(this.transaction);
}
