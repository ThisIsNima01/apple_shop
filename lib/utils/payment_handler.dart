import 'package:apple_shop/utils/extensions/string_extensions.dart';
import 'package:apple_shop/utils/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();

  Future<void> sendPaymentRequest();

  Future<void> verifyPaymentRequest();
}

class ZarinpalPayment extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  final UrlHandler _urlHandler;
  String? _authority;
  String? _status;
  ZarinpalPayment(this._urlHandler);

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setDescription('تراکنش تستی از اپل شاپ');
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    _paymentRequest.setCallbackURL('nimanaderi://shop');
    _paymentRequest.amount = 2424242;

    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('authority')) {
        _authority = deepLink.extractValueFromQuery('Authority');
        _status = deepLink.extractValueFromQuery('Status');
        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) async {
      if (status == 100) {
        // if 100 => Success Request => Can Use paymentGatewayUri

        _urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(_status!, _authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) async {
      if (isPaymentSuccess) {
        print(refID);
      } else {
        print('object');
      }
      // _isPaymentSuccess = isPaymentSuccess;
      // transactionRefId = refID ?? '0';

      // if (isPaymentSuccess) {  
      //   await _basketRepository.clearBasket();
      //   add(BasketPaymentResponseEvent());
      // } else {
      //   add(BasketPaymentResponseEvent());
      //   await Future.delayed(const Duration(seconds: 10));
      //   add(BasketFetchFromHiveEvent());
      // }
    });
  }
}
