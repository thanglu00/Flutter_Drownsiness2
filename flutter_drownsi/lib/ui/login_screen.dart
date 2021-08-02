import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/authentication/auth_provider.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_controller_screen.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserPostData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserRepo.dart';
import 'package:flutter_drownsi/ui/turnOnDevice_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100.0),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100.0),
                  Image.asset("assets/images/logo.png", height: 250),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton.icon(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.grey),
                        color: Colors.green,
                        highlightedBorderColor: Colors.green,
                        textColor: Colors.red,
                        label: Text("Sign in with Google"),
                        icon: Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
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
                                phoneNumber: "string",
                                uuid: FirebaseAuth.instance.currentUser!.uid);
                            var check;
                            await _handleLogin(context,p).then((value){
                              check = value.active;

                              if(check) {
                                print(check);
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
                    ],
                  ),
                  const SizedBox(height: 10.0,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 8.0),
                    child: InkWell(
                      child:
                      Text(
                        "Offline feature >>>",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          color: Colors.greenAccent[700],
                          fontSize:12,
                        ),

                      ),
                      onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => TurnOnOffDevice())) ,
                    ),
                  ),
                ],
              ),
            ),
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
      Navigator.of(context,rootNavigator: true).pop();
      if (!_response.active) {
        AuthClass().signOut();
        showDialog(context: context, builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 16,
            child: Container(
              height: 300,
              width: 200,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Image(
                    image: AssetImage("assets/images/deactive.png"),
                    width: 150.0,
                  ),
                  SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Login failed! Your account is not active.', style: TextStyle(color: Colors.red)),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }

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
                        CircularProgressIndicator(
                          color: Colors.green,
                        ),
                        SizedBox(height: 10,),
                        Text("Please Wait....",
                          style: TextStyle(color: Colors.green))
                      ]),
                    )
                  ]));
        });
  }
}
