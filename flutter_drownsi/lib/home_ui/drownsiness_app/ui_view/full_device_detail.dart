import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/FirmwareData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/title_view.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserDeviceRepo.dart';
import 'package:flutter_drownsi/ui/utils/MyTools.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class FullDeviceDetail extends StatefulWidget {
  final UserResponse userResponse;
  final UserDevice userDevice;

  const FullDeviceDetail({Key? key, required this.userResponse, required this.userDevice}) : super(key: key);

  @override
  FullDeviceDetailState createState() => FullDeviceDetailState();
}

class FullDeviceDetailState extends State<FullDeviceDetail> with TickerProviderStateMixin{

  TextEditingController nameController = new TextEditingController();
  UserDeviceRepo userDeviceRepo = new UserDeviceRepo();
  bool _status = true;
  List<Widget> listWidgets = <Widget>[];
  late Firmware fw;

  String checkUpdate = "none";
  bool isCheckUpdate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Connected Device"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child:SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/jetson.png",
                  width: 200,
                ),
                SizedBox(width: 30),
                Text(
                  "Model: NVIDIA Jetson Nano \n\n" +
                  "CPU: Quad-core ARM Cortex-A57 \n\n" +
                  "GPU: 128 NVIDIA CUDA® cores \n\n" +
                  "Memory: 4 GB\n\n" +
                  "Storage: 16 GB",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(5),
                    child: Text('Device information', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 3.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'ID: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.userDevice.deviceId,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 5.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'Name: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            new Flexible(
                                              child: new TextField(
                                                controller: nameController..text = widget.userDevice.deviceName,
                                                decoration: _status ? InputDecoration(
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.zero,
                                                  border: InputBorder.none,
                                                  hintText: "Enter your name",
                                                ) : InputDecoration(
                                                  isDense: true,
                                                  hintText: "Enter your name",
                                                ),
                                                enabled: !_status,
                                                autofocus: !_status,
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status ? _getEditIcon() : _getEditIcon2(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 5.0, bottom: 10.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'Connected at: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              MyTools.readTimestamp(widget.userDevice.createdAt),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 25),
                    child: Text('Firmware information', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 10.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'ID: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.userDevice.firmware.firmwareId,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 10.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'About: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.userDevice.firmware.description,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),

                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 10.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'Update at: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              MyTools.readTimestamp(widget.userDevice.firmware.createdAt),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),

                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, top: 10.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'Version: ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              (widget.userDevice.firmware.createdAt / 1000).round().toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),

                                          ],
                                        )),
                                    checkUpdate == "none" ?
                                    Center(
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              checkUpdate = "updating";
                                            });
                                            userDeviceRepo.getLastestFirmware(widget.userResponse.token).then((value) {
                                              if(value != null) {
                                                setState(() {
                                                  fw = value;
                                                  checkUpdate = "none";
                                                  isCheckUpdate = true;
                                                });
                                              } else {
                                                setState(() {
                                                  fw = new Firmware('null', 'null', 'null', 0, 0);
                                                  checkUpdate = "none";
                                                  isCheckUpdate = true;
                                                });
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('Check for Update', style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 13,
                                              )),
                                              SizedBox(width: 10,),
                                              Icon(
                                                Icons.system_update_alt_sharp,
                                                color: Colors.green,
                                                size: 24.0,
                                                semanticLabel: 'Text to announce in accessibility modes',
                                              ),
                                            ],
                                          ),
                                        )
                                    ) :
                                    Center(
                                        child: TextButton(
                                          onPressed: () {
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('Getting update...', style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 13,
                                              )),
                                              SizedBox(width: 10,),
                                              SizedBox(
                                                child: CircularProgressIndicator(
                                                  color: Colors.green,
                                                ),
                                                height: 15,
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    checkUpdate != "none" ? SizedBox(width: 0) :
                                    isCheckUpdate ? 
                                      (fw.firmwareId != "null" ?
                                            Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 10.0),
                                                    child: new Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: <Widget>[
                                                        Text(
                                                          'ID: ',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          fw.firmwareId,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 10.0),
                                                    child: new Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: <Widget>[
                                                        Text(
                                                          'About: ',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          fw.description,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),

                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 10.0),
                                                    child: new Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: <Widget>[
                                                        Text(
                                                          'Update at: ',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          MyTools.readTimestamp(fw.createdAt),
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),

                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 10.0),
                                                    child: new Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: <Widget>[
                                                        Text(
                                                          'Version: ',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          (fw.createdAt / 1000).round().toString(),
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),

                                                      ],
                                                    )),
                                              ],
                                            ) :
                                            Text('Your firmware is lastest!', style: TextStyle(color: Colors.green, fontSize: 14))) :
                                        SizedBox(width: 0)
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ]),
          ),
        ));
  }

  void createWidget() {
    if (checkUpdate == "none") {
      setState(() {
        listWidgets = <Widget>[];
        listWidgets.add(Center(
            child: TextButton(
              onPressed: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Check for Update', style: TextStyle(
                    color: Colors.green,
                    fontSize: 13,
                  )),
                  SizedBox(width: 10,),
                  Icon(
                    Icons.system_update_alt_sharp,
                    color: Colors.green,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ],
              ),
            )
        ));
      });
    }
    return;
  }

  Future<bool> refresh() async {
    AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=> FullDeviceDetail(userResponse: widget.userResponse, userDevice: widget.userDevice)));
    return Future.value(false);
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getEditIcon2() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        radius: 14.0,
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 20.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = true;
        });
      },
    );
  }
}
