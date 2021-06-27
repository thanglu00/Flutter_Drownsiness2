
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DeviceData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/historyDrownsiness_data.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DataTrackingRepo.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DeviceRepo.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class TrackingDetail extends StatefulWidget {
    final DrownsinessDataTracking dataTracking;
    final String token;
    const TrackingDetail({Key? key, required this.dataTracking, required this.token}) : super(key: key);
    @override
    TrackingDetailState createState() => TrackingDetailState();
}

class TrackingDetailState extends State<TrackingDetail>{
  DrownsinessData? data;
  List<DrownsinessData> listData = DrownsinessData.trackingList;
  Device? deviceData;
  DrownsinessDataTracking? _dataTracking;
  @override
  void initState() {
    DataTrackingRepo().getDataTrackingById(widget.dataTracking.trackingID, widget.token).then((value1){
      DeviceRepo().getDevice(value1.deviceId, widget.token).then((value2){
        setState(() {
          deviceData = value2;
          _dataTracking = value1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(deviceData == null){
      return
          Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
    }else {
      return Scaffold(
        appBar: AppBar(
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
                      Image(image: NetworkImage(widget.dataTracking.imageUrl),
                        width: 200,
                        height: 200,),
                      SizedBox(
                        height: 40,
                      ),
                      Text("Tracking ID : ", style: TextStyle(fontSize: 18),),
                      Text(widget.dataTracking.getTrackingID,
                        style: TextStyle(fontSize: 18),),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Device Tracking : " + deviceData!.deviceName,
                        style: TextStyle(fontSize: 18),),
                      SizedBox(
                        height: 10,
                      ),
                      Text("At date : " + widget.dataTracking.getTrackingDay,
                        style: TextStyle(fontSize: 18),),
                      SizedBox(
                        height: 10,
                      ),
                      Text("You was drownsiness at " +
                          widget.dataTracking.getTrackingTime,
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

}