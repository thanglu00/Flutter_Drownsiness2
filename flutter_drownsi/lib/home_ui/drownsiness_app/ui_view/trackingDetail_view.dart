
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/historyDrownsiness_data.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class TrackingDetail extends StatelessWidget{
  DrownsinessData? data;
  List<DrownsinessData> listData = DrownsinessData.trackingList;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
              appBar:AppBar(
                title: Text("History tracking"),
                centerTitle: true,
                backgroundColor: Colors.greenAccent,
              ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 500,
                  width: 500,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(listData[0].imagePath, width: 200, height: 200,),
                          SizedBox(
                            height: 40,
                          ),
                          Text("Name : "+ listData[0].userName, style: TextStyle(fontSize: 18),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("At date : " + listData[0].dateTime!.day.toString() + "/" + listData[0].dateTime!.month.toString() + "/" + listData[0].dateTime!.year.toString(),
                            style: TextStyle(fontSize: 18),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("You was drownsiness at "+listData[0].dateTime!.hour.toString() +":"+ listData[0].dateTime!.minute.toString(),
                            style: TextStyle(fontSize: 18),),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }

}