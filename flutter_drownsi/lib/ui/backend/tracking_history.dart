import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDTO.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/full_history.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/tracking_detail.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DataTrackingRepo.dart';
import 'package:flutter_drownsi/ui/utils/MyTools.dart';

class TrackingHistoryWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final UserResponse userResponse1;

  const TrackingHistoryWidget(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.userResponse1})
      : super(key: key);

  @override
  MyTrackingHistoryWidget createState() => MyTrackingHistoryWidget();
}

class MyTrackingHistoryWidget extends State<TrackingHistoryWidget> {
  DataTrackingRepo dataRepo = new DataTrackingRepo();
  List<DatatrackingDTO>? listData;
  List<Widget> listWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    listWidgets.add(Padding(
      padding: EdgeInsets.all(15.0),
      child: Text('No record!', style: TextStyle(color: Colors.red)),
    ));
    dataRepo
        .getByUserId(widget.userResponse1.userId, widget.userResponse1.token)
        .then((value) {
      if (value != null) {
        if(value.isNotEmpty) {
          setState(() {
            listData = value;
            listWidgets = <Widget>[];
            listWidgets = createWidget(listData!);
          });
        }
      }
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
                child: Column(children: listWidgets),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> createWidget(List<DatatrackingDTO> list) {
    List<Widget> listWidget = <Widget>[];
    int count = 0;
    for (var d in list) {
      count++;
      listWidget.add(InkWell(
          onTap: (){
            _ontapItem(context, d);
          },
          child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
            Image.network(
              d.imageUrl,
              width: 100.0,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(
                    Icons.perm_device_info,
                    color: Colors.grey,
                    size: 22.0,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    d.deviceName,
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
                    MyTools.readTimestamp(d.trackingAt),
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
      if(count == 4) {
        listWidget.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _ontapMore(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        'More',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.green,
                        size: 30.0,
                      ),
                    ],
                  )
              )
            ],
          )
        );
        break;
      }
    }
    return listWidget;
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  void _ontapItem(BuildContext context, DatatrackingDTO? dto) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrackingDetails(
                  dto: dto!, userResponse: widget.userResponse1,
                )));
  }

  void _ontapMore(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullHistory(
              userResponse: widget.userResponse1,
            )));
  }
}
