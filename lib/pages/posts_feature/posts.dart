import 'package:chatapp_firebase/pages/posts_feature/addposts.dart';
import 'package:chatapp_firebase/pages/profile_feature/pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../chat_feature/ChatPage.dart';

class posts extends StatefulWidget {
  const posts({super.key});

  @override
  State<posts> createState() => _posts();
}

class _posts extends State<posts> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf6a806),
        leading: IconButton(
          onPressed: (){
            nextScreen(context, const Pro());
          }, icon: const Icon(
            Icons.person
        ),
        ),
        centerTitle: true,
        title: Text('Posts', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
      ),
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> addpost()));
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('loading..');
        }
        return ListView(
          itemExtent: 95.0,
          shrinkWrap: true,
          children: snapshot.data!.docs.map<Widget>((doc)=>_buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data= document.data()! as Map<String, dynamic>;
    return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFf6a806),
          ),
            title: Text(data['title']),
            subtitle: Text(data['name']),
          ),
        );
  }
}
