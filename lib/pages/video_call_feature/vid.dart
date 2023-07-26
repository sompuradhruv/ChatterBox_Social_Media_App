import 'package:chatapp_firebase/pages/profile_feature/pro.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

import '../../widgets/widgets.dart';

var appSign= '486b41801a35533a8baecbb667fc14d8626e2bd2de714a6b65cbfd87b6508165';
var appID= 549335253;
final String localUserID= math.Random().nextInt(10000).toString();

class test extends StatelessWidget {
  var nc=TextEditingController();
  var nc2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text('Video Call', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
      ),

      body:
      Padding(
        padding: const EdgeInsets.fromLTRB(100,200,100,0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
            height: 213,
            width: 800,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text("Enter the Room ID"),
                  TextField(
                    controller: nc,
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CallPage(callID: nc.text);
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf6a806),
                      ),
                      child: const Text(
                    'Enter Room',
                  )),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }


}

class CallPage extends StatelessWidget{
  final String callID;

  const CallPage({
    Key? key,
    required this.callID,
  }):super(key:key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
          appID: appID,
          appSign: appSign,
          userID: localUserID,
          userName: "user_$localUserID",
          callID: callID,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ..onOnlySelfInRoom=(context){
              Navigator.of(context).pop();
            }
      ),
    );
  }
}

