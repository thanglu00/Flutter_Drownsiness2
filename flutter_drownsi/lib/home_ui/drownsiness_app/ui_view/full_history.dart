import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDTO.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/tracking_detail.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/DataTrackingRepo.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter_drownsi/ui/utils/MyTools.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class FullHistory extends StatefulWidget {
  final UserResponse userResponse;

  const FullHistory({Key? key, required this.userResponse}) : super(key: key);

  @override
  FullHistoryState createState() => FullHistoryState();
}

class FullHistoryState extends State<FullHistory> with TickerProviderStateMixin{

  DataTrackingRepo dataRepo = new DataTrackingRepo();
  List<DatatrackingDTO>? listData;
  List<Widget> listWidgets = <Widget>[];
  List<String> listDevice = [];
  String currentDevice = "All devices";
  bool is_filter = false;
  int x = 0, y = 0;

  @override
  void initState() {
    super.initState();
    listWidgets.add(Padding(
      padding: EdgeInsets.all(15.0),
      child: Text('No record!', style: TextStyle(color: Colors.red)),
    ));
    dataRepo
        .getByUserId(widget.userResponse.userId, widget.userResponse.token)
        .then((value) {
      if (value != null) {
        setState(() {
          listData = value;
          listWidgets = <Widget>[];
          listWidgets = createWidget(listData!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History tracking"),
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
                            Builder(
                              builder: (context) => RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.green,
                                          size: 22.0,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Date",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                onPressed: () async {
                                  final List<DateTime> picked = await DateRangePicker.showDatePicker(
                                      context: context,
                                      initialFirstDate: new DateTime.now(),
                                      initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                                      firstDate: new DateTime(2021),
                                      lastDate: new DateTime(DateTime.now().year + 2));
                                  if (picked != null && picked.length >= 1) {
                                    setState(() {
                                      is_filter = true;
                                      x = DateTime.parse(DateFormat("yyyy-MM-dd").format(picked.first)).millisecondsSinceEpoch;
                                      y = DateTime.parse(DateFormat("yyyy-MM-dd").format(picked.last)).millisecondsSinceEpoch;
                                      listWidgets = createWidget(listData!);
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            DropdownButton<String>(
                              hint: Text('Select device:'),
                              value: currentDevice,
                              iconSize: 22,
                              elevation: 12,
                              style: const TextStyle(color: Colors.black, fontSize: 12),
                              underline: Container(
                                height: 2,
                                color: Colors.green,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  if(newValue != "All devices") {
                                    is_filter = true;
                                  } else {
                                    is_filter = false;
                                  }
                                  currentDevice = newValue!;
                                  listWidgets = createWidget(listData!);
                                });
                              },
                              items: listDevice.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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

  List<Widget> createWidget(List<DatatrackingDTO> list) {
    listDevice.add("All devices");
    List<Widget> listWidget = <Widget>[];
    int count = 0;
    for (var d in list) {
      listDevice.add(d.deviceName);
      if (x != 0) {
        int tmp = DateTime.parse(MyTools.readDate(d.trackingAt)).millisecondsSinceEpoch;
        if (tmp < x || tmp > y) {
          continue;
        }
      }

      if(currentDevice != "All devices") {
        if(currentDevice.compareTo(d.deviceName) != 0) {
          continue;
        }
      }
      count ++;
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

  void _ontapItem(BuildContext context, DatatrackingDTO? dto) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrackingDetails(
              dto: dto!,userResponse: widget.userResponse,
            )));
  }

  Future<bool> refresh() async {
    AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=> FullHistory(userResponse: widget.userResponse)));
    return Future.value(false);
  }
}
