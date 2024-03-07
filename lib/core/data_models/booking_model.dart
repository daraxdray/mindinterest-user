import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking({
    this.id,
    this.uid,
    this.cid,
    this.meetLink,
    this.startTime,
    this.endTime,
    this.day,
    this.date,
    this.bookingId,
    this.cost,
    this.paymentMethod,
    this.therapist,
    this.status,
    this.createdAt,
    this.user,
    this.therapistPictureUrl,
    this.userPicture,
    this.updatedAt,
    this.paymentData,
  });

  int? id;
  int? uid;
  int? cid;
  String? meetLink;
  int? startTime;
  int? endTime;
  int? day;
  String? date;
  String? bookingId;
  int? cost;
  String? paymentMethod;
  String? therapist;
  String? therapistPictureUrl;
  String? user;
  String? userPicture;

  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  PaymentData? paymentData;

  Booking copyWith(
          {int? id,
          int? uid,
          int? cid,
            String? meetLink,
          int? startTime,
          int? endTime,
          int? day,
          String? date,
          String? bookingId,
          int? cost,
          String? paymentMethod,
          String? therapist,
          String? status,
          DateTime? createdAt,
          String? therapistPictureUrl,
          String? user,
          PaymentData? paymentData,
          String? userPicture}) =>
      Booking(
          id: id ?? this.id,
          uid: uid ?? this.uid,
          cid: cid ?? this.cid,
          meetLink: meetLink ?? this.meetLink,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          day: day ?? this.day,
          date: date ?? this.date,
          bookingId: bookingId ?? this.bookingId,
          cost: cost ?? this.cost,
          paymentMethod: paymentMethod ?? this.paymentMethod,
          therapist: therapist ?? this.therapist,
          status: status ?? this.status,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          user: user ?? user,
          paymentData: paymentData ?? this.paymentData,
          therapistPictureUrl: therapistPictureUrl ?? therapistPictureUrl,
          userPicture: userPicture ?? userPicture);

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        uid: json["uid"],
        cid: json["cid"],
    meetLink: json["meetLink"] ?? "https://the-mind-interst.whereby.com/themindinterest-bfe1d840-a5d6-490f-a5ab-cd4d8478b5e0",
        startTime: json["start_time"],
        endTime: json["end_time"],
        day: json["day"],
        date: json["date"],
        bookingId: json["booking_id"],
        cost: json["cost"],
        paymentMethod: json["payment_method"],
        therapist: json["therapist"],
        status: json["status"],
        paymentData: json['payment_data'] == null
            ? null
            : PaymentData.fromJson(json['payment_data']),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: json["user"] ?? '',
        userPicture: json["user_profile_img"] ?? '',
        therapistPictureUrl: json["therapist_profile_img"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "cid": cid,
        "meetLink":meetLink,
        "user": user,
        "user_profile_img": userPicture,
        "therapist_profile_img": therapistPictureUrl,
        "start_time": startTime,
        "end_time": endTime,
        "day": day,
        "date": date,
        "booking_id": bookingId,
        "cost": cost,
        "payment_method": paymentMethod,
        "therapist": therapist,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };

  String get conversationId => '$uid-$cid';

  bool get isActive => status!.toLowerCase().trim() == 'inprogress';
  DateTime? get parsedStartDate =>
      DateTime.tryParse(date!.split('/').reversed.toList().join('-'));
}

class PaymentData {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PaymentData({
    this.authorizationUrl,
    this.accessCode,
    this.reference,
  });
  PaymentData.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url']?.toString();
    accessCode = json['access_code']?.toString();
    reference = json['reference']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['authorization_url'] = authorizationUrl;
    data['access_code'] = accessCode;
    data['reference'] = reference;
    return data;
  }
}
