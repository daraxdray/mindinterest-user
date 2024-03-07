import 'package:logger/logger.dart';
import 'package:mindintrest_user/utils/logger.dart';

class Utils {
  static String cleanPhoneNumberWithStatusCode(
      {String countryCode = '+234', required String phone}) {
    if (phone.startsWith('0')) {
      tmiLogger.log(Level.info, '$countryCode${phone.substring(1)}');
      return '$countryCode${phone.substring(1)}';
    } else {
      return '$phone';
    }
  }

  static String getTimeFromDigit(int digit) {
    print(digit);
    if (digit < 12) {
      return '${digit}am';
    } else if (digit == 12) {
      return '12pm';
    } else {
      return '${digit - 12}pm';
    }
  }
}
