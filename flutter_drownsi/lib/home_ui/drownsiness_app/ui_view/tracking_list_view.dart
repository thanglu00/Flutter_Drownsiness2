import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDate.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingOnDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/trackingDetail_view.dart';
import 'package:collection/collection.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DeviceRepo.dart';


class ListDrownsiness extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final UserResponse userResponse1;
  const ListDrownsiness({Key? key, required this.animationController, required this.animation, required this.userResponse1})
      : super(key: key);

  @override
  MyListDrownsiness createState() => MyListDrownsiness();

}
class MyListDrownsiness extends State<ListDrownsiness> {

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
                  left: 24, right: 24, top: 16, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(48.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Today 8:26 AM',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 14),
                                    child: Text(
                                      'Ban da ngu gat',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color: Colors.redAccent,
                                        // color: FitnessAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            child: RaisedButton(
                              onPressed: (){
                                setState(() {
                                  listViews.clear();
                                  addAllListDataDay();
                                });
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              // color: HexColor("#79a6ed"),
                              color: Colors.greenAccent[400],
                              child: Text("Day"),
                            ),
                            height: 36,
                            minWidth: 70,
                          ),
                          ButtonTheme(
                            child: FlatButton(
                                onPressed: (){
                                  setState(() {
                                    listViews.clear();
                                    addAllListDataMonth();
                                  });
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                color: Colors.greenAccent[400],
                                child: Text("Month")
                            ),
                            height: 36,
                            minWidth: 70,
                          ),
                          ButtonTheme(
                            child: FlatButton(
                                onPressed: (){
                                  setState(() {
                                    listViews.clear();
                                    addAllListDataYear();
                                  });
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                color: Colors.greenAccent[400],
                                child: Text("Year")),
                            height: 36,
                            minWidth: 70,
                          ),

                        ],
                      ),
                    ),
                    //
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 8, bottom: 8),
                        child: listViews.isNotEmpty == true ? new Column(
                          children: listViews,
                        ) : new Column(
                          children: [CircularProgressIndicator()],
                        )
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
  List<Widget> listViews = <Widget>[];
  List<DrownsinessDataTracking> listData = <DrownsinessDataTracking>[];
  List<DataTrackingDay> datatmp = <DataTrackingDay>[];
  Map<String, List<DrownsinessDataTracking>>? _map;
  void addAllListDataDay(){
    listViews.clear();
    _map = groupBy(listData, (DrownsinessDataTracking d){
      return d.getTrackingDay;
    });
    print("success");
    print(_map);
    for(var j in _map!.keys){
      listViews.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 170, 10),
            child: Text(j.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0) ,textAlign: TextAlign.left,),
          )
      );
      List<DrownsinessDataTracking>? listData = _map![j];
      for(var k in listData!){
        listViews.add(
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: (){
                _ontapItem(context,k);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(image:NetworkImage(k.getImageUrl),),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          k.getTrackingDay,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Alert at ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              k.getTrackingTime,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),),
        );
      }
    }
  }
  void addAllListDataMonth(){
    listViews.clear();
    _map = groupBy(listData, (DrownsinessDataTracking d){
      var listDay = d.getTrackingDay.split("/");
      var value = listDay[1] + "/"+ listDay[2];
      return value;
    });
    print("success");
    print(_map);
    for(var j in _map!.keys){
      listViews.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 170, 10),
            child: Text(j.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0) ,textAlign: TextAlign.left,),
          )
      );
      List<DrownsinessDataTracking>? listData = _map![j];
      for(var k in listData!){
        listViews.add(
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: (){
                _ontapItem(context,k);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(image:NetworkImage(k.getImageUrl),),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          k.getTrackingDay,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Alert at ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              k.getTrackingTime,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),),
        );
      }
    }

  }
  void addAllListDataYear(){
    listViews.clear();
    _map = groupBy(listData, (DrownsinessDataTracking d){
      var listDay = d.getTrackingDay.split("/");
      var value = listDay[2];
      return value;
    });
    print("success");
    print(_map);
    for(var j in _map!.keys){
      listViews.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 170, 10),
            child: Text(j.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0) ,textAlign: TextAlign.left,),
          )
      );
      List<DrownsinessDataTracking>? listData = _map![j];
      for(var k in listData!){
        listViews.add(
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: (){
                _ontapItem(context,k);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(image:NetworkImage(k.getImageUrl),),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          k.getTrackingDay,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Alert at ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              k.getTrackingTime,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),),
        );
      }
    }
  }
  int count = 0;

  @override
  void initState() {
      super.initState();
      DeviceRepo().getDataTrackingWithDevice(widget.userResponse1.userId, widget.userResponse1.token)
          .then((value){
            print(value);
            List<DataTrackingOnEachDevice> dataTracking = value;
            List<DrownsinessDataTracking> listTmp = <DrownsinessDataTracking>[];
            for(var u in dataTracking){
              for(var j in u.getDataTracking.reversed){
                listTmp.add(j);
            }
            }
            setState(() {
              listData = listTmp;
              addAllListDataDay();
            });
          });
      addAllListDataDay();
  } // @override
  void _ontapItem(BuildContext context, DrownsinessDataTracking? drownsinessDataTracking){
    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingDetail(dataTracking: drownsinessDataTracking!, token: widget.userResponse1.token,)));
  }
}
