import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? text;
  final DateTime? date;
  final int? senderID;

  ChatModel({this.text, this.date, this.senderID});

  factory ChatModel.fromJson(Map<String, dynamic>? json) {
    return ChatModel(
        date: (json!['timestamp'] as Timestamp).toDate(),
        senderID: json["sender_id"],
        text: json['text']);
  }

  Map<String, dynamic> toJson() =>
      {'sender_id': senderID, 'text': text, 'timestamp': Timestamp.now()};
}
