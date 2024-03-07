import 'booking_model.dart';

class BookingResponseModel {
  BookingResponseModel({
    this.amount,
    this.paymentData,
  });

  int? amount;
  PaymentData? paymentData;

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingResponseModel(
        amount: json["amount"] ?? 100,
        paymentData: json["payment_data"] == null
            ? null
            : PaymentData.fromJson(json["payment_data"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "payment_data": paymentData?.toJson(),
      };
}
