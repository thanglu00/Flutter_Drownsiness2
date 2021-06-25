import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/authentication/auth_provider.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_controller_screen.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserPostData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserRepo.dart';
import 'package:flutter_drownsi/ui/home_screen.dart';
import 'package:flutter_drownsi/ui/otp_screen.dart';
import 'package:flutter_drownsi/ui/splash_login_screen.dart';
import 'package:flutter_drownsi/ui/turnOnDevice_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100.0),
            Stack(
              children: <Widget>[
                Positioned(
                  left: 20.0,
                  top: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20.0)),
                    width: 70.0,
                    height: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
              child: TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+84'),
                    ),
                    labelText: "Phone number", hasFloatingPlaceholder: true),

              ),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: RaisedButton(
                padding: const EdgeInsets.fromLTRB(40.0, 16.0, 20.0, 16.0),
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
                onPressed: () {
                  if(phoneController.text.isNotEmpty){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(phoneController.text)));
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Send OTP".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    const SizedBox(width: 10.0),
                    Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 18.0,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 122, vertical: 8.0),
              child: Text('or you can sign by', textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton.icon(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30.0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red),
                  color: Colors.red,
                  highlightedBorderColor: Colors.red,
                  textColor: Colors.red,
                  icon: Icon(
                    FontAwesomeIcons.googlePlusG,
                    size: 18.0,
                  ),
                  label: Text("Google"),
                  onPressed: () {
                    //sign in with google
                    AuthClass()
                        .signInWithGoogle()
                        .then((value) async {
                      final displayname = value.user!.displayName;
                      print(displayname);
                      UserPost p = new UserPost(
                          imgUrl: FirebaseAuth.instance.currentUser!.photoURL,
                          gmail :FirebaseAuth.instance.currentUser!.email,
                          name: FirebaseAuth.instance.currentUser!.displayName,
                          phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber,
                          uuid: FirebaseAuth.instance.currentUser!.uid);
                      var check;
                      await _handleLogin(context,p).then((value){
                        check = value.active;

                      if(check) {
                        print(check);
                        print("Login success");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrownsinessAppHomeScreen(userResponse:value,)),
                                (route) => false);
                      }
                      });
                    });
                  },
                ),
                const SizedBox(width: 10.0),
                OutlineButton.icon(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30.0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  highlightedBorderColor: Colors.indigo,
                  borderSide: BorderSide(color: Colors.indigo),
                  color: Colors.indigo,
                  textColor: Colors.indigo,
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    size: 18.0,
                  ),
                  label: Text("Facebook"),
                  onPressed: () {
                    AuthClass()
                        .signInWithFacebook()
                        .then((value) async {
                      final displayname = value.user!.displayName;
                      print(displayname);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrownsinessAppHomeScreen(userResponse: value,)),
                              (route)=> false);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 40.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 8.0),
              child: InkWell(
                child:
                Text(
                  "Control the device offline >>>",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      color: Colors.greenAccent[700],
                      fontSize:18,
                  ),

                ),
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => TurnOnOffDevice())) ,
              ),
            )
          ],
        ),
      ),
    );
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<UserResponse> _handleLogin(BuildContext context,UserPost p) async {
    UserResponse _response = UserResponse("userId", "username", "fullName", "password", "phoneNumber", "email", "avatar", 0000, 0000, "token", "type", false);
    try{
      Dialogs.showLoadingDialog(context, _keyLoader);
      await UserRepo().getAuthoLogin(p).then((value){
        _response = value;
      });
      Navigator.of(context,rootNavigator: true).pop();//close the dialoge
    }catch(error){
      print(error);
    }
    return _response;
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context,
      GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}
