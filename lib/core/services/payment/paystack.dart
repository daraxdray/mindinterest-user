import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:mindintrest_user/app/flavor_config.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/utils/logger.dart';

class PaystackPayment {
  static Future<CheckoutResponse> chargeCard(BuildContext context,
      {required int amount,
      required String ref,
      required TmiUser user,
      String? accessCode}) async {
    tmiLogger.i(ref);
    final plugin = PaystackPlugin();
    await plugin.initialize(publicKey: EnvCredentials.paystackKey);
    Charge charge = Charge()
      ..amount = amount * 100 //convert to kobo
      ..reference = ref
      ..accessCode = accessCode
      ..email = 'me@you.com'; //TODO: get user's emails
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    return response;
  }
}
