import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String toDollar() {
    return NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(this);
  }
}