import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../config/theme/app_colors.dart';
import '../data/model/transaction.dart';

class Utils {
  static Jalali now = Jalali.now();

  static String getFullCurrentDate() =>
      '${now.minute < 10 ? 0 : ''}${now.minute} / ${now.hour < 10 ? 0 : ''}${now.hour} - ${now.formatter.d} / ${now.formatter.m} / ${now.formatter.y}';

  static List getTransactionData(Transaction transaction) => [
        ['شماره تراکنش', transaction.refID],
        ['زمان پرداخت', transaction.paymentTime.toString()],
        ['روش پرداخت', transaction.paymentMethod],
        ['فروشنده', transaction.seller],
        ['مبلغ نهایی', '${transaction.totalPrice} تومان'],
        ['مقدار تخفیف', '${transaction.discountAmount} تومان'],
        ['وضعیت پرداخت', transaction.isSuccess ? 'موفق' : 'ناموفق'],
      ];

  static Color getTransactionTitleColor(int index) =>
      index == 5 ? AppColors.red : AppColors.grey;

  static Color getTransactionValueColor(int index, String value) {
    if (index != 6 && index != 5) {
      return Colors.black;
    }

    if (index == 6) {
      if (value == 'موفق') {
        return AppColors.green;
      } else {
        return AppColors.red;
      }
    } else {
      return AppColors.red;
    }
  }
}
