import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_controller_screen.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserPostData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserRepo.dart';
import 'package:flutter_drownsi/ui/login_screen.dart';

class SplashLogin extends StatefulWidget{
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashLogin>{
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserResponse? _response;
  UserPost p = new UserPost(
      imgUrl: FirebaseAuth.instance.currentUser!.photoURL,
      gmail :FirebaseAuth.instance.currentUser!.email,
      name: FirebaseAuth.instance.currentUser!.displayName,
      phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber,
      uuid: FirebaseAuth.instance.currentUser!.uid);
  var check;
  @override
  void initState() {
    UserRepo().getAuthoLogin(p).then((value){
      setState(() {
        _response = value;
        check = _response!.active;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1),(){
      if(check == true){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
      }else{
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context)=> DrownsinessAppHomeScreen()),
        //         (route) => false);
      }
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }

}