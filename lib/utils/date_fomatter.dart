import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDayAndMonth(DateTime? date) {
    if (date == null) {
      return '- -';
    }
    return DateFormat('d MMMM').format(date);
  }

  static String formatDateFull(DateTime? date) {
    if (date == null) {
      return '- -';
    }
    return DateFormat('d MMM, yyyy').format(date);
  }

  static formatBubbleTime(DateTime? date) {
    if (date == null) {
      return '- -';
    }
    return DateFormat('hh:mm aa').format(date);
  }
}
