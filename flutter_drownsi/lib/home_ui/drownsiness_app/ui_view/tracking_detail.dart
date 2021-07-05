import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDTO.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DataTrackingRepo.dart';
import 'package:flutter_drownsi/ui/utils/MyTools.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class TrackingDetails extends StatefulWidget {
  final DatatrackingDTO dto;
  final UserResponse userResponse;

  const TrackingDetails({Key? key, required this.dto, required this.userResponse}) : super(key: key);

  @override
  TrackingDetailsState createState() => TrackingDetailsState();
}

class TrackingDetailsState extends State<TrackingDetails> {

  DataTrackingRepo dataRepo = new DataTrackingRepo();
  List<Widget> listWidgets = [];
  bool? check;

  @override
  void initState() {
    super.initState();
    listWidgets = getStateWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History tracking"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Container(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image(
                        image: NetworkImage(widget.dto.imageUrl),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(children: [
                        Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.dto.dataTrackingId,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Icon(
                          Icons.perm_device_info,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.dto.deviceName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Icon(
                          Icons.history_toggle_off_outlined,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          MyTools.readTimestamp(widget.dto.trackingAt),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () async {
                                showDialog(context: context, builder: (context){
                                  return Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                      width: 200,
                                      height: 90,
                                      child: Column(
                                        children: getStateWidgets(),
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getStateWidgets() {
    listWidgets.clear();
    listWidgets.add(SizedBox(height: 10));
    listWidgets.add(Text(
      'Are you sure to delete?',
      style: TextStyle(color: Colors.black),
    ),);
    listWidgets.add(const Divider(
      height: 5,
      thickness: 1,
      indent: 50,
      endIndent: 50,
      color: Colors.black12,
    ));
    listWidgets.add(SizedBox(height: 10));
    listWidgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child:
          Text(
            "Cancel",
            style: TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.green,
              fontSize:18,
            ),
          ),
          onTap:() => Navigator.pop(context),
        ),
        SizedBox(width: 25),
        InkWell(
          child:
          Text(
            "OK",
            style: TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.red,
              fontSize:18,
            ),
          ),
          onTap:() async {
            Navigator.pop(context);
            showDialog(context: context, builder: (context){
              return  Dialog (
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  width: 200,
                  height: 90,
                  child: Column(
                    children: getDeleteStateWidgets(),
                  ),
                ),
              );
            });
            check = await dataRepo.deleteById(widget.dto.dataTrackingId, widget.userResponse.token);
            Navigator.pop(context);
            showDialog(context: context, builder: (context){
              return  Dialog (
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  width: 200,
                  height: 90,
                  child: Column(
                    children: resultWidgets(check!),
                  ),
                ),
              );
            });
            await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    ));

    return listWidgets;
  }

  List<Widget> getDeleteStateWidgets() {
    listWidgets.clear();
    listWidgets.add(
        Center(
          child: Column(children: [
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: Colors.green,
            ),
            SizedBox(height: 5,),
            Text("Please Wait....",
                style: TextStyle(color: Colors.green))
          ]),
        )
    );
    return listWidgets;
  }

  List<Widget> resultWidgets(bool x) {
    listWidgets.clear();

    x ? listWidgets.add(
        Center(
          child: Column(children: [
            SizedBox(height: 10),
            Icon(
              Icons.check,
              color: Colors.green,
              size: 40.0,
            ),
            SizedBox(height: 5,),
            Text("Successed!",
                style: TextStyle(color: Colors.green))
          ]),
        )
    ) :
    listWidgets.add(
        Center(
          child: Column(children: [
            SizedBox(height: 10),
            Icon(
              Icons.clear,
              color: Colors.red,
              size: 40.0,
            ),
            SizedBox(height: 5,),
            Text("Failed!",
                style: TextStyle(color: Colors.red))
          ]),
        ));
    return listWidgets;
  }
}
