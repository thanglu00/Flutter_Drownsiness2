import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserDeviceRepo.dart';
import 'package:flutter_drownsi/ui/utils/MyTools.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class FullConnectHistory extends StatefulWidget {
  final UserResponse userResponse;

  const FullConnectHistory({Key? key, required this.userResponse}) : super(key: key);

  @override
  FullConnectHistoryState createState() => FullConnectHistoryState();
}

class FullConnectHistoryState extends State<FullConnectHistory> with TickerProviderStateMixin{

  UserDeviceRepo dataRepo = new UserDeviceRepo();
  List<UserDevice>? listData;
  List<Widget> listWidgets = <Widget>[];
  List<String> listDevice = [];
  String currentDevice = "All devices";
  bool is_filter = false;
  int x = 0, y = 0;

  @override
  void initState() {
    super.initState();
    listWidgets.add(
        Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
                height: 20,
                width: 20,
              ),
              SizedBox(width: 15),
              Text(
                  'Please wait...',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12
                  )
              ),
              SizedBox(width: 60),
            ],
          ),
        )
    );
    dataRepo
        .getHistoryByUserId(widget.userResponse.userId, widget.userResponse.token)
        .then((value) {
      if (value != null) {
        if(value.isNotEmpty) {
          setState(() {
            listData = value;
            listWidgets = <Widget>[];
            listWidgets = createWidget(listData!);
          });
        } else {
          setState(() {
            listWidgets = <Widget>[];
            listWidgets.add(Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('No record!', style: TextStyle(color: Colors.red)),
            ));
          });
        }
      } else {
        setState(() {
          listWidgets = <Widget>[];
          listWidgets.add(Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('No record!', style: TextStyle(color: Colors.red)),
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Connect history"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child:SingleChildScrollView(
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
                          Theme(
                              data: Theme.of(context).copyWith(
                                  accentColor: Colors.green,
                                  primaryColor: Colors.green,
                                  buttonTheme: ButtonThemeData(
                                      highlightColor: Colors.green,
                                      buttonColor: Colors.green,
                                      colorScheme: Theme.of(context).colorScheme.copyWith(
                                          secondary: Colors.red,
                                          background: Colors.white,
                                          primary: Colors.green,
                                          primaryVariant: Colors.green,
                                          brightness: Brightness.light,
                                          onBackground: Colors.green),
                                      textTheme: ButtonTextTheme.accent)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  is_filter ? Builder(
                                    builder: (context) => InkWell(
                                      child: Padding(
                                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                                size: 22.0,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Clear",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      onTap: () {
                                        setState(() {
                                          is_filter = false;
                                          x = y = 0;
                                          listWidgets = createWidget(listData!);
                                          currentDevice = "All devices";
                                        });
                                      },
                                    ),
                                  ) : const SizedBox(width: 0),
                                ],
                              )
                          ),
                          Column(
                            children: listWidgets,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  List<Widget> createWidget(List<UserDevice> list) {
    List<Widget> listWidget = <Widget>[];
    int count = 0;
    for (var d in list) {
      count ++;
      listWidget.add(InkWell(
          onTap: (){
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(
                        Icons.format_list_numbered,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        count.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Icon(
                        Icons.perm_device_info,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Device: ' + d.deviceName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Icon(
                        Icons.history_toggle_off,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Last connect: ' + MyTools.readTimestamp(d.connectedAt),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Icon(
                        Icons.history_toggle_off,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Last disconnect: ' + MyTools.readTimestamp(d.disconnectedAt),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Icon(
                        Icons.insert_link,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Status: ' + (d.connected == true ? 'is connecting' : 'disconnected'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )
                    ]),

                  ],
                )
              ],
            ),
          )));
      listWidget.add(
        const Divider(
          height: 5,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.black12,
        ),
      );
    }
    if (count == 0) {
      listWidget.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Colors.white,
              ),
              Text('No data!',style: TextStyle(color: Colors.red))
            ],
          )
      );
    }
    listDevice = listDevice.toSet().toList();
    return listWidget;
  }


  Future<bool> refresh() async {
    AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=> FullConnectHistory(userResponse: widget.userResponse)));
    return Future.value(false);
  }
}
