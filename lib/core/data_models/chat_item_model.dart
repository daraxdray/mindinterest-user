import 'package:mindintrest_user/core/data_models/chat_model.dart';

class ChatItemModel {
  ChatItemModel({this.cid, this.uid, this.lastMesage, this.id});
  final int? cid;
  final int? uid;
  final ChatModel? lastMesage;
  final String? id;

  String get conversationId => '$uid-$cid';

  factory ChatItemModel.fromJson(
      Map<String, dynamic>? json, String firestoreId) {
    return ChatItemModel(
        id: firestoreId,
        cid: json!['cid'],
        uid: json['uid'],
        lastMesage: json['last_message'] == null
            ? null
            : ChatModel.fromJson(json['last_message']));
  }
}
