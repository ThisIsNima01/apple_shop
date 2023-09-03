class Transaction {
  bool isSuccess;
  String totalPrice;
  String discountAmount;
  String refID;
  String paymentTime;
  String paymentMethod;
  String seller;

  Transaction(
      {required this.isSuccess,
      required this.totalPrice,
      required this.discountAmount,
      required this.refID,
      required this.paymentTime,
      required this.paymentMethod,
      required this.seller});
}
