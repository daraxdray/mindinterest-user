import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double? d, {bool currencyPrefix = false}) {
    const currencySymbol = '₦';
    final fmt = NumberFormat('#,##0.##', 'en_US').format(d);
    return !currencyPrefix ? fmt : '$currencySymbol$fmt';
  }
}
