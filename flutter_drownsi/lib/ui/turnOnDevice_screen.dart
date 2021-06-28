import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TurnOnOffDevice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String qrData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Back to Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SizedBox(
            width: 250,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 30.0,),
                    Text(
                      'Control device',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(width: 10.0,),
                    Image(
                      image: AssetImage("assets/images/qr_icon.png"),
                      width: 50.0,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                FlatButton(
                  height: 100,
                  onPressed: ()=>{
                  qrData = "command=turnon",
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 16,
                      child: Container(
                        height: 400,
                        width: 300,
                        child: Column(
                          children: [
                            QrImage(data: qrData, padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20)),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Scan QR code to ', style: TextStyle(color: Colors.black)),
                                    TextSpan(text: 'turn on', style: TextStyle(color: Colors.green)),
                                    TextSpan(text: ' detect feature', style: TextStyle(color: Colors.black)),
                                  ]
                              ),
                            ),
                            SizedBox(height: 5,),
                            Image(
                              image: AssetImage("assets/images/qr_icon.png"),
                              width: 50.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/turn on.png"),
                        width: 200.0,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  height: 100,
                  onPressed: ()=>{
                  qrData = "command=turnoff",
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 16,
                      child: Container(
                        height: 400,
                        width: 300,
                        child: Column(
                          children: [
                            QrImage(data: qrData, padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20)),
                            RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Scan QR code to ', style: TextStyle(color: Colors.black)),
                                    TextSpan(text: 'turn off', style: TextStyle(color: Colors.red)),
                                    TextSpan(text: ' detect feature', style: TextStyle(color: Colors.black)),
                                  ]
                                ),
                            ),
                            SizedBox(height: 5,),
                            Image(
                              image: AssetImage("assets/images/qr_icon.png"),
                              width: 50.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/turn off.png"),
                        width: 200.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}