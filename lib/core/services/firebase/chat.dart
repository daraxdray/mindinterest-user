import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindintrest_user/core/data_models/chat_model.dart';

class ChatService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      int cid, int uid, String bookingId, ChatModel chatModel) async {
//TODO: optimize

    await _firestore.collection('conversations').doc(bookingId).set({
      'cid': cid,
      'uid': uid,
      'last_message': chatModel.toJson(),
      'timestamp': Timestamp.now()
    });
    await _firestore
        .collection('conversation_messages')
        .doc(bookingId)
        .collection('all_messages')
        .add(chatModel.toJson());
  }
}
