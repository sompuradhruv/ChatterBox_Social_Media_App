import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  const about({Key? key}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    return ws();
  }
}

class ws extends State<about>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('About The Creator', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
          backgroundColor: Color(0xFFf6a806),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none, alignment: Alignment.center,
                children: [
                  Image(
                      height: 200,
                      width: 500,
                      fit: BoxFit.cover,
                      image: NetworkImage('https://e0.pxfuel.com/wallpapers/897/233/desktop-wallpaper-minimalist-landscape-yellow.jpg')),
                  Positioned(
                      bottom: -50.0,
                      child:
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xFFf6a806),
                        backgroundImage: AssetImage('assets/images/propic.png'),))
                ],
              ),
              SizedBox(height: 50),
              ListTile(title: Center(child: Text('Dhruv Sompura', style: TextStyle(fontSize: 20),)), subtitle: Center(child: Text('Android App Developer||VIT Vellore \'24',style: TextStyle(fontSize: 15))),),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFf6a806),
                ),
                onPressed: (){
                  _launchURLBrowser();
                },
                icon: Icon( // <-- Icon
                  Icons.mail,
                ),
                label: Text('LinkedIn'), // <-- Text
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFf6a806),
                ),
                onPressed: (){
                  _launchURLApp();
                },
                icon: Icon( // <-- Icon
                  Icons.hub,
                ),
                label: Text('GitHub'), // <-- Text
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('About Me',style: TextStyle(fontSize: 17)),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 0, 4),
                      child: Text(
                          '👋 Hello! Welcome to my App and Thank You for using it\! \nI am Dhruv Sompura- A learner and programmer who build this application\. \nThis application was built to help me learn how to deploy an application on Google\'s playstore. Turns out I can do it! This app was created using Dart language for Flutter\.\nThank you for using this app, and stay tuned for a much bigger project coming soon!😊',
                          style: TextStyle(fontSize:15)),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }}

_launchURLBrowser() async {
  final Uri url = Uri.parse('https://www.linkedin.com/in/dhruv-sompura-8b5854203/');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLApp() async {
  const url = 'https://github.com/sompuradhruv';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}