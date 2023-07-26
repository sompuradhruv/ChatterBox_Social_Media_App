import 'package:chatapp_firebase/pages/bot.dart';
import 'package:chatapp_firebase/pages/posts_feature/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_firebase/service/group_service.dart';

class addpost extends StatefulWidget {
  const addpost({super.key});

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {

  String name=" ";
  final postController=TextEditingController();
  bool loading=false;
  final userCollection = FirebaseFirestore.instance.collection("posts");
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf6a806),
        centerTitle: true,
        title: Text("Add Post", style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot){
                  name=snapshot.data!.docs.map<String>((doc)=>_buildUserListItem(doc)).toString();
              return Text("");
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            maxLines: 4,
            controller: postController,
            decoration: InputDecoration(
              hintText: "Write something for everyone to see",
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFf6a806), // Background color
            ),
            onPressed: () {
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              userCollection.doc().set({
                'name': name,
                'title': postController.text.toString(),
                'id': id
              }).then((value) => {null});
              Navigator.of(context).pop();
            }, child: Text("Add"),
          )
        ],
      ),
    );
  }

  _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data= document.data()! as Map<String, dynamic>;
    if(_auth.currentUser!.email==data['email']){
      return(data['fullName']);
    }
    return "Name";
  }

}
