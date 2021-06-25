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
            width: 200,
            child: Column(
              children: [
                FlatButton(
                  height: 100,
                  onPressed: ()=>{
                  qrData = "turn on device",
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 300,
                        width: 260,
                        child: Column(
                          children: [
                            QrImage(data: qrData, padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20)),
                          ],
                        ),
                      ),
                    );
                  })
                },
                  color: HexColor("#2ad921"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
                      Text('Turn on device',textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  height: 100,
                  onPressed: ()=>{
                  qrData = "turn off device",
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 300,
                        width: 260,
                        child: Column(
                          children: [
                            QrImage(data: qrData, padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20)),
                          ],
                        ),
                      ),
                    );
                  })
                },
                  color: HexColor("#d94621"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
                      Text('Turn off device',textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
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