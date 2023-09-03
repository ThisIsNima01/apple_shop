import 'package:intl/intl.dart';

extension IntExtention on int {
  String separateByComma() {
    var formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}