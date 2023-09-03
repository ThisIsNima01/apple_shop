import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/data/model/transaction.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/utils/extensions/string_extensions.dart';
import 'package:apple_shop/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

import '../../data/model/basket_item.dart';
import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  int totalPrice = 0;
  String transactionRefId = '';
  bool? _isPaymentSuccess;
  final PaymentRequest _paymentRequest = PaymentRequest()
    ..setIsSandBox(true)
    ..setDescription('تراکنش تستی از اپل شاپ')
    ..setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc')
    ..setCallbackURL('nimanaderi://shop');

  Either<String, List<BasketItem>>? basketList;
  List<int>? basketValuesSummary;

  BasketBloc() : super(BasketInitState()) {
    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('authority')) {
        String? authority = deepLink.extractValueFromQuery('Authority');
        String? status = deepLink.extractValueFromQuery('Status');
        ZarinPal().verificationPayment(status!, authority!, _paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) async {
          _isPaymentSuccess = isPaymentSuccess;
          transactionRefId = refID ?? '0';

          if (isPaymentSuccess) {
            await _basketRepository.clearBasket();
            add(BasketPaymentResponseEvent());
          } else {
            add(BasketPaymentResponseEvent());
            await Future.delayed(const Duration(seconds: 10));
            add(BasketFetchFromHiveEvent());
          }
        });
      }
    });

    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItems();
        var basketSummary = await _basketRepository.getFinalBasketPrice();

        totalPrice = basketSummary[2];
        _paymentRequest.amount = totalPrice;
        basketList = basketItemList;
        basketValuesSummary = basketSummary;
        emit(BasketDataFetchedState(basketItemList, basketSummary, false));
      },
    );

    on<BasketItemDeleted>(
      (event, emit) async {
        basketList = await _basketRepository.deleteBasketItem(event.basketItem);
        basketValuesSummary = await _basketRepository.getFinalBasketPrice();
        add(BasketFetchFromHiveEvent());
      },
    );

    on<BasketItemAdded>((event, emit) async {
      _basketRepository.addProductToBasket(event.cartItem);
      add(BasketFetchFromHiveEvent());
    });

    on<BasketPaymentResponseEvent>(
      (event, emit) {
        emit(
          TransactionResponseState(
            Transaction(
              isSuccess: _isPaymentSuccess!,
              paymentTime: Utils.getFullCurrentDate(),
              seller: 'اپل شاپ',
              paymentMethod: 'درگاه پرداخت',
              discountAmount: basketValuesSummary![1].separateByComma(),
              refID: transactionRefId,
              totalPrice: totalPrice.separateByComma(),
            ),
          ),
        );
      },
    );

    on<BasketPaymentRequestEvent>(
      (event, emit) async {
        emit(BasketDataFetchedState(basketList!, basketValuesSummary!, true));

        await Future.delayed(const Duration(seconds: 3));

        ZarinPal().startPayment(_paymentRequest,
            (status, paymentGatewayUri) async {
          if (status == 100) {
            // if 100 => Success Request => Can Use paymentGatewayUri

            await launchUrl(Uri.parse(paymentGatewayUri!),
                mode: LaunchMode.externalApplication);
          }
        });
        emit(BasketDataFetchedState(basketList!, basketValuesSummary!, false));
      },
    );
  }
}
