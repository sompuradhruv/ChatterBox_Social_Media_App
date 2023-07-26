import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/message.dart';

class ChatService extends ChangeNotifier {
// get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverld, String message) async {
    final String currentUserId= _firebaseAuth.currentUser!.uid;
    final String currentUserEmail= _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp=Timestamp.now();

    Message newMessage=Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverld,
      timestamp: timestamp,
      message: message
    );

    List<String> ids=[currentUserId, receiverld];
    ids.sort();
    String chatRoomId=ids.join("_");
    await _fireStore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    List<String> ids=[userId, otherUserId];
    ids.sort();
    String chatRoomId=ids.join("_");
    return _fireStore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timestamp',descending:false).snapshots();
  }
}
