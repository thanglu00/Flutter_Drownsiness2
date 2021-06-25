import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/title_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter_drownsi/main.dart';
import '../drownsiness_app_theme.dart';
import 'buttonQR_view.dart';
import 'logout_button_view.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key, required this.animationController}) : super(key: key);

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
    const int count = 5;
    listViews.add(
      ButtonQR(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        button1: FlatButton(onPressed: () =>{
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
              Text('Turn on device',textAlign: TextAlign.left, style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        button2: FlatButton(onPressed: () =>{
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
              Text('Turn off device',textAlign: TextAlign.left, style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
    listViews.add(
      ButtonQR(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        button1: FlatButton(onPressed: ()=>{
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
              Text('Turn on device',textAlign: TextAlign.left, style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        button2: FlatButton(onPressed: ()=>{
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_left, color: Colors.white,),
              Text('Turn off device',textAlign: TextAlign.left, style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
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
                  39,
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
                                child: Text(
                                  'Scan QR Code',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
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