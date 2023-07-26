import 'package:chatapp_firebase/pages/profile_feature/pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import 'ChatPage.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf6a806),
        leading: IconButton(
          onPressed: (){
            nextScreen(context, const Pro());
          }, icon: const Icon(
            Icons.person
        ),
        ),
        title: Text('Chat', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('loading..');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc)=>_buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data= document.data()! as Map<String, dynamic>;
    if(_auth.currentUser!.email!=data['email']){
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              data['fullName'].substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            data['fullName'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Chat with ${data["fullName"]}",
            style: const TextStyle(fontSize: 13),
          ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage(
                receiverUserEmail: data['fullName'],
                receiverUserID: data['uid'],
              ),));
            }
        ),
      );
    }
    return Container();
  }
}
