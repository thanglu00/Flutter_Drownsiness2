import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/FirmwareData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/full_connect_history.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/full_device_detail.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/trackingDetail_view.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserDeviceRepo.dart';
import 'package:flutter_drownsi/ui/utils/MyTools.dart';
import 'package:qr_flutter/qr_flutter.dart';


class LinkedDeviceWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final UserResponse userResponse1;

  const LinkedDeviceWidget(
      {Key? key, required this.animationController, required this.animation, required this.userResponse1})
      : super(key: key);

  @override
  MyLinkedDeviceWidget createState() => MyLinkedDeviceWidget();

}

class MyLinkedDeviceWidget extends State<LinkedDeviceWidget> {

  List<Widget> listWidgets = [];
  UserDeviceRepo userDeviceRepo = new UserDeviceRepo();
  UserDevice userDeviceDTO = new UserDevice("null", "null", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
  String checkUpdate = '';

  @override
  void initState() {
    super.initState();

    userDeviceRepo.getCurrentConnect(
        widget.userResponse1.userId, widget.userResponse1.token)
        .then((value) {
          if(value == null) {
            setState(() {
              userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
            });
          } else if (value.active == false) {
            userDeviceRepo.setConnectionUserInDevice(widget.userResponse1.token, widget.userResponse1.userId, value.deviceId);
            setState(() {
              userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
            });
            showDialog(context: context, builder: (context){
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 16,
                child: Container(
                  width: 300,
                  height: 100,
                  child: Column(
                    children: getStateWidgets2(),
                  ),
                ),
              );
            });
          } else {
              userDeviceRepo.getLastestFirmware(widget.userResponse1.token).then((fw) {
                if (value != null) {
                  setState(() {
                    if (fw!.firmwareId != value.firmware.firmwareId) {
                      checkUpdate = "Old version";
                      showDialog(context: context, builder: (context){
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 16,
                          child: Container(
                            width: 300,
                            height: 90,
                            child: Column(
                              children: getStateWidgets(),
                            ),
                          ),
                        );
                      });
                    }
                    userDeviceDTO = value;
                  });
                } else {
                  setState(() {
                    userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
                  });
                }
              });
          };
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 4, bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(width: 5),
                        (userDeviceDTO.deviceName == 'null' || userDeviceDTO.deviceName == 'nulled') ?
                        SizedBox(width: 70, height: 50,) :
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullConnectHistory(
                                        userResponse: widget.userResponse1,
                                      )));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.grey,
                                  size: 30.0,
                                  semanticLabel: 'Text to announce in accessibility modes',
                                ),
                                Text(
                                  'History',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 7,
                                  ),
                                )
                              ],
                            )
                        ),
                        // Container(
                        //   height: 60,
                        //   width: 60,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         image: AssetImage(
                        //             'assets/images/link_device.png'),
                        //       )
                        //   ),
                        // ),
                        const SizedBox(width: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ignore: unnecessary_null_comparison
                            userDeviceDTO.deviceName == 'null' ?
                            Row(
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
                            ) :
                            userDeviceDTO.deviceName == 'nulled' ?
                            Text(
                              'Not connect any device yet!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12
                              ),
                            ) :
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5.0),
                                Text('Device: ' + userDeviceDTO.deviceName),
                                Text(
                                  'At: ' + MyTools.readTimestamp(
                                      userDeviceDTO.createdAt),
                                  style: TextStyle(fontSize: 10),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Firmware: ' + (userDeviceDTO.firmware.createdAt / 1000).round().toString(),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                            checkUpdate,
                                          style: TextStyle(
                                              fontSize: 7,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10.0),
                        (userDeviceDTO.deviceName == 'null' || userDeviceDTO.deviceName == 'nulled') ?
                        SizedBox(width: 30) :
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullDeviceDetail(
                                        userResponse: widget.userResponse1, userDevice: userDeviceDTO,
                                      )));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.green,
                                  size: 35.0,
                                  semanticLabel: 'Text to announce in accessibility modes',
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                    const Divider(
                      height: 5,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: TextButton(
                              onPressed: () async {
                                //userDeviceRepo.getLastestConnected(widget.userResponse1.token, widget.userResponse1.userId)
                                String qrData = "connect_" + widget.userResponse1.userId + '_' + widget.userResponse1.username;
                                showDialog(context: context, builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    elevation: 16,
                                    child: Container(
                                      height: 400,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          QrImage(data: qrData,
                                              padding: const EdgeInsets.only(
                                                  top: 20,
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20)),
                                          Center(
                                            child: RichText(
                                              text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(text: 'Scan QR code to ',
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    TextSpan(text: 'connect',
                                                        style: TextStyle(
                                                            color: Colors.green)),
                                                    TextSpan(text: ' to device',
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    TextSpan(text: '\nUser: ',
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    TextSpan(text: widget.userResponse1.username,
                                                        style: TextStyle(
                                                            color: Colors.green)),
                                                  ]
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Image(
                                            image: AssetImage(
                                                "assets/images/qr_icon.png"),
                                            width: 50.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).then((value) async {
                                  setState(() {
                                    userDeviceDTO = new UserDevice("null", "null", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
                                  });
                                  userDeviceRepo.getCurrentConnect(
                                      widget.userResponse1.userId, widget.userResponse1.token)
                                      .then((value) {
                                    if(value == null) {
                                      setState(() {
                                        userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
                                      });
                                    } else if (value.active == false) {
                                      userDeviceRepo.setConnectionUserInDevice(widget.userResponse1.token, widget.userResponse1.userId, value.deviceId);
                                      setState(() {
                                        userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
                                      });
                                      showDialog(context: context, builder: (context){
                                        return Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                          elevation: 16,
                                          child: Container(
                                            width: 300,
                                            height: 100,
                                            child: Column(
                                              children: getStateWidgets2(),
                                            ),
                                          ),
                                        );
                                      });
                                    } else {
                                      userDeviceRepo.getLastestFirmware(widget.userResponse1.token).then((fw) {
                                        if (value != null) {
                                          setState(() {
                                            if (fw!.firmwareId != value.firmware.firmwareId) {
                                              checkUpdate = "Old version";
                                              showDialog(context: context, builder: (context){
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                  elevation: 16,
                                                  child: Container(
                                                    width: 300,
                                                    height: 90,
                                                    child: Column(
                                                      children: getStateWidgets(),
                                                    ),
                                                  ),
                                                );
                                              });
                                            }
                                            userDeviceDTO = value;
                                          });
                                        } else {
                                          setState(() {
                                            userDeviceDTO = new UserDevice("null", "nulled", 0, 0, new Firmware('null', 'null', 'null', 0, 0, false), 'null', true);
                                          });
                                        }
                                      });
                                    };
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 24.0,
                                    semanticLabel: 'Text to announce in accessibility modes',
                                  ),
                                  Text('Connect device', style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                  ),)
                                ],
                              ),
                            )
                        ),
                        // const SizedBox(
                        //   width: 1.0,
                        //   height: 20.0,
                        //   child: const DecoratedBox(
                        //     decoration: const BoxDecoration(
                        //         color: Colors.grey
                        //     ),
                        //   ),
                        // ),
                        //History button

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  void _ontapItem(BuildContext context,
      DrownsinessDataTracking? drownsinessDataTracking) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        TrackingDetail(dataTracking: drownsinessDataTracking!,
          token: widget.userResponse1.token,)));
  }

  List<Widget> getStateWidgets() {
    listWidgets.clear();
    listWidgets.add(SizedBox(height: 10));
    listWidgets.add(Text(
      'New firmware version is detected!',
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
              color: Colors.red,
              fontSize:18,
            ),
          ),
          onTap:() => Navigator.pop(context),
        ),
        SizedBox(width: 25),
        InkWell(
          child:
          Text(
            "Next",
            style: TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.green,
              fontSize:18,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullDeviceDetail(
                      userResponse: widget.userResponse1, userDevice: userDeviceDTO,
                    )));
          },
        ),
      ],
    ));

    return listWidgets;
  }

  List<Widget> getStateWidgets2() {
    listWidgets.clear();
    listWidgets.add(SizedBox(height: 10));
    listWidgets.add(Center(child: Text(
      'CONNECT FAILED!\n Your device is banned from server!',
      style: TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    )));
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
            "OK",
            style: TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.green,
              fontSize:18,
            ),
          ),
          onTap:() => Navigator.pop(context),
        ),
      ],
    ));

    return listWidgets;
  }
}
