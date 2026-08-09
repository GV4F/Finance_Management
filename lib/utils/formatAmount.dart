import 'package:intl/intl.dart';
  String formatAmount(double value) {
    final formatCurrency = NumberFormat.currency(locale: 'es_GT', symbol: 'Q', customPattern: '¤#,##0.00');
    return formatCurrency.format(value);
  }