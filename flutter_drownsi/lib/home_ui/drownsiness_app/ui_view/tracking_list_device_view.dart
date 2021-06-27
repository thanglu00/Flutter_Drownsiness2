import 'package:flutter_drownsi/home_ui/drownsiness_app/drownsiness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDate.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingOnDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/trackingDetail_view.dart';
import 'package:collection/collection.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DeviceRepo.dart';


class ListDrownsinessByDevice extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final UserResponse userResponse1;
  const ListDrownsinessByDevice({Key? key, required this.animationController, required this.animation, required this.userResponse1})
      : super(key: key);

  @override
  MyListDrownsinessByDevice createState() => MyListDrownsinessByDevice();

}
class MyListDrownsinessByDevice extends State<ListDrownsinessByDevice> {

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
                  left: 24, right: 24, top: 8, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 4.0, top: 8),
                      child: Text(
                        'Device',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                          FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.0,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 8, bottom: 5),
                      child: _buildPanel(),
                    ),
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

  List<DataList> dataDevice =<DataList>[];
  List<ExpansionPanel> deviceExpansionPanel = <ExpansionPanel>[];
  @override
  void initState() {
    super.initState();
    DeviceRepo().getDataTrackingWithDevice(widget.userResponse1.userId, widget.userResponse1.token)
        .then((value){
      print(value);
      List<DataTrackingOnEachDevice> dataTracking = value;
      List<DataList> dataDevicetmp =<DataList>[];
      for(var u in dataTracking){
        List<Card> listDeviceTrackingData = <Card>[];
        for(var j in u.getDataTracking.reversed){
          listDeviceTrackingData.add(
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                onTap: (){
                  _ontapItem(context,j);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image(image:NetworkImage(j.getImageUrl),),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            j.getTrackingDay,
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
                                j.getTrackingTime,
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
        dataDevicetmp.add(DataList(u.device.deviceName, listDeviceTrackingData,false));
      }
      setState(() {
        dataDevice = dataDevicetmp;
      });
    });
  } // @override
  void _ontapItem(BuildContext context, DrownsinessDataTracking? drownsinessDataTracking){
    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingDetail(dataTracking: drownsinessDataTracking!, token: widget.userResponse1.token,)));
  }

  Widget _buildPanel() {
    return Container(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            dataDevice[index].checkExpand = !isExpanded;
          });
        },
        children: dataDevice.map<ExpansionPanel>((DataList item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.deviceName),
              );
            },
            body: Column(
              children: item.dataDevcieTracking,
            ),
            isExpanded: item.checkExpand,
          );
        }).toList(),
      ),
    );
  }
}

class DataList{
  final String deviceName;
  final List<Card> dataDevcieTracking;
  bool checkExpand = false;

  DataList(this.deviceName, this.dataDevcieTracking,this.checkExpand);

}