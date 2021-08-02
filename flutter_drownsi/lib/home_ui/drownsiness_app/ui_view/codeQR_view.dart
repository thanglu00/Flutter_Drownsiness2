import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../drownsiness_app_theme.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key, required this.animationController, required this.userResponse}) : super(key: key);

  final UserResponse userResponse;
  final AnimationController animationController;
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen>
    with TickerProviderStateMixin {
  late Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    final ButtonStyle raisedButtonStyleRed = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.red)
      ),
    );
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.green)
      ),
    );
    listViews.add(
        Padding(
            padding: EdgeInsets.only(left: 50, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      String qrData = "connect_" + widget.userResponse.userId + '_' + widget.userResponse.username;
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
                                          TextSpan(text: widget.userResponse.username,
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/link_device.png', width: 100.0,),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.green,
                        ),
                        Text(
                          'Link device',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(width: 30),
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      String qrData = "upload_" + widget.userResponse.userId + '_' + widget.userResponse.username;
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
                                          TextSpan(text: 'upload',
                                              style: TextStyle(
                                                  color: Colors.green)),
                                          TextSpan(text: ' \ntraking data from device',
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/cloud.png', width: 100.0,),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.green,
                        ),
                        Text(
                          'Upload tracking data',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              )
            ],
          ),
        )
    );
    listViews.add(
        Padding(
          padding: EdgeInsets.only(left: 50, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      String qrData = "activate";
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
                                          TextSpan(text: 'turn on',
                                              style: TextStyle(
                                                  color: Colors.green)),
                                          TextSpan(text: ' detection \nfeature on device',
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/turn on.png', width: 100.0,),
                        SizedBox(height: 35),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.green,
                        ),
                        Text(
                          'Turn on detection',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(width: 30),
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyleRed,
                    onPressed: () {
                      String qrData = "deactivate";
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
                                          TextSpan(text: 'turn off',
                                              style: TextStyle(
                                                  color: Colors.red)),
                                          TextSpan(text: ' detection \nfeature on device',
                                              style: TextStyle(

                                                  color: Colors.black)),
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/turn off.png', width: 100.0,),
                        SizedBox(height: 35),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.red,
                        ),
                        Text(
                          'Turn on detection',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        )
    );
    listViews.add(
        Padding(
          padding: EdgeInsets.only(left: 50, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      String qrData = "update";
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
                                          TextSpan(text: 'get update',
                                              style: TextStyle(
                                                  color: Colors.green)),
                                          TextSpan(text: ' firmware on device',
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/update.png', width: 100.0,),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.green,
                        ),
                        Text(
                          'Get update',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(width: 30),
              Container(
                width: 140,
                height: 170,
                child: ElevatedButton(
                    style: raisedButtonStyleRed,
                    onPressed: () {
                      String qrData = "shutdown";
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
                                          TextSpan(text: 'shut down',
                                              style: TextStyle(
                                                  color: Colors.red)),
                                          TextSpan(text: ' device',
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/shutdown.png', width: 100.0,),
                        Divider(
                          height: 5,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.red,
                        ),
                        Text(
                          'Shutdown device',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    return true;
  }
  String qrData="https://github.com/ChinmayMunje";
  final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  90,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 30 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/qr_icon.png"),
                                      width: 70.0,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Control detection kit by QR code',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      height: 5,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}