import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_controller_screen.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserPostData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserRepo.dart';
import 'package:flutter_drownsi/ui/home_screen.dart';
import 'package:flutter_drownsi/ui/login_screen.dart';

class Splash extends StatefulWidget{
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1),() async {
      if(auth.currentUser == null){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
      }else{
        UserPost p = new UserPost(
            imgUrl: FirebaseAuth.instance.currentUser!.photoURL,
            gmail :FirebaseAuth.instance.currentUser!.email,
            name: FirebaseAuth.instance.currentUser!.displayName,
            phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber,
            uuid: FirebaseAuth.instance.currentUser!.uid);
        await UserRepo().getAuthoLogin(p).then((value){
          if(value.active){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context)=> DrownsinessAppHomeScreen(userResponse: value)),
                    (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
          }
        });

      }
    });
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 80,
        ),
      ),
    );
  }

}