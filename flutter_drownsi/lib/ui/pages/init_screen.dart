import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/ui/utils/my_constant.dart';
import 'package:flutter_drownsi/ui/utils/my_navigator.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    Timer(Duration(seconds: 3), () => MyNavigator.goToSplash(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage('assets/images/logo.png'),
                          width: 200
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14.0,
                          fontFamily: 'Canterbury',
                        ),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(
                                MyConstant.name
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      MyConstant.store,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 14.0,
                          color: Colors.green),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}