import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drownsi/authentication/auth_provider.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/ProfileData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/ProfileDataUpdate.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/util/UserRepo.dart';
import 'package:flutter_drownsi/ui/login_screen.dart';

class ProfilePage extends StatefulWidget {
  final UserResponse userResponse;
  const ProfilePage({Key? key, required this.userResponse}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  ProfileData? _data;
  TextEditingController nameController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserRepo().getUser(widget.userResponse.userId,widget.userResponse.token).then((value){
      _data = value;
      setState(() {
        nameController.text = _data!.getfullName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_data == null){
      return Center(child: CircularProgressIndicator());
    }
    else{
      return new Scaffold(
          body: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        height: 250.0,
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 20.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: new Text('PROFILE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'sans-serif-light',
                                              color: Colors.black)),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(fit: StackFit.loose, children: <Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              image:
                                              NetworkImage(_data!.getavatar),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Personal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            hintText: "Enter your name",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,

                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: TextEditingController(text: _data!.getemail),
                                          decoration: const InputDecoration(
                                              hintText: "Enter your email ID"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: TextEditingController(text: _data!.getphoneNumber),
                                          decoration: const InputDecoration(
                                              hintText: "Input your phonenumber"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Device',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Version',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            controller: TextEditingController(text: "Jetson Nano"),
                                            decoration: const InputDecoration(
                                                hintText: "Enter your device"),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          controller: TextEditingController(text: "1.1.1"),
                                          decoration: const InputDecoration(
                                              hintText: "1.1.1"),
                                          enabled: false,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                              _status ? _getLogoutButtons() : new Container(),
                              SizedBox(height: 60,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      var result = UserRepo().updateUser(widget.userResponse.userId,widget.userResponse.token, ProfileDataUpdate(true, _data!.getavatar, _data!.getemail, nameController.text, _data!.getemail, _data!.getusername));
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  Widget _getLogoutButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Log out"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
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
}


// class ProfilePage extends StatefulWidget {
//   @override
//   MapScreenState createState() => MapScreenState();
// }
//
// class MapScreenState extends State<ProfilePage>
//     with SingleTickerProviderStateMixin {
//   bool _status = true;
//   final FocusNode myFocusNode = FocusNode();
//   String? user = FirebaseAuth.instance.currentUser!.email == null
//       ? FirebaseAuth.instance.currentUser!.phoneNumber
//       : FirebaseAuth.instance.currentUser!.email;
//   String? image = FirebaseAuth.instance.currentUser!.photoURL;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: new Container(
//           color: Colors.white,
//           child: new ListView(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     new Container(
//                       height: 250.0,
//                       color: Colors.white,
//                       child: new Column(
//                         children: <Widget>[
//                           Padding(
//                               padding: EdgeInsets.only(left: 8.0, top: 20.0),
//                               child: new Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 8.0),
//                                     child: new Text('PROFILE',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20.0,
//                                             fontFamily: 'sans-serif-light',
//                                             color: Colors.black)),
//                                   )
//                                 ],
//                               )),
//                           Padding(
//                             padding: EdgeInsets.only(top: 20.0),
//                             child: new Stack(fit: StackFit.loose, children: <Widget>[
//                               new Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   new Container(
//                                       width: 140.0,
//                                       height: 140.0,
//                                       decoration: new BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         image: new DecorationImage(
//                                           image:
//                                               NetworkImage(image!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(top: 90.0, right: 100.0),
//                                   child: new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       new CircleAvatar(
//                                         backgroundColor: Colors.red,
//                                         radius: 25.0,
//                                         child: new Icon(
//                                           Icons.camera_alt,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                             ]),
//                           )
//                         ],
//                       ),
//                     ),
//                     new Container(
//                       color: Color(0xffFFFFFF),
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 25.0),
//                         child: new Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         new Text(
//                                           'Personal Information',
//                                           style: TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         _status ? _getEditIcon() : new Container(),
//                                       ],
//                                     )
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         new Text(
//                                           'Name',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Flexible(
//                                       child: new TextField(
//                                         controller: TextEditingController(text: FirebaseAuth.instance.currentUser!.displayName),
//                                         decoration: const InputDecoration(
//                                           hintText: "Enter your name",
//                                         ),
//                                         enabled: !_status,
//                                         autofocus: !_status,
//
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         new Text(
//                                           'Email ID',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Flexible(
//                                       child: new TextField(
//                                         controller: TextEditingController(text: FirebaseAuth.instance.currentUser!.email),
//                                         decoration: const InputDecoration(
//                                             hintText: "Enter your email ID"),
//                                         enabled: !_status,
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         new Text(
//                                           'Mobile',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Flexible(
//                                       child: new TextField(
//                                         controller: TextEditingController(text: FirebaseAuth.instance.currentUser!.phoneNumber),
//                                         decoration: const InputDecoration(
//                                             hintText: "Input your phonenumber"),
//                                         enabled: !_status,
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: Container(
//                                         child: new Text(
//                                           'Device',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       flex: 2,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         child: new Text(
//                                           'Version',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       flex: 2,
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Flexible(
//                                       child: Padding(
//                                         padding: EdgeInsets.only(right: 10.0),
//                                         child: new TextField(
//                                           controller: TextEditingController(text: "Jetson Nano"),
//                                           decoration: const InputDecoration(
//                                                 hintText: "Enter your device"),
//                                           enabled: !_status,
//                                         ),
//                                       ),
//                                       flex: 2,
//                                     ),
//                                     Flexible(
//                                       child: new TextField(
//                                         controller: TextEditingController(text: "1.1.1"),
//                                         decoration: const InputDecoration(
//                                             hintText: "1.1.1"),
//                                         enabled: false,
//                                       ),
//                                       flex: 2,
//                                     ),
//                                   ],
//                                 )),
//                             !_status ? _getActionButtons() : new Container(),
//                             _status ? _getLogoutButtons() : new Container(),
//                             SizedBox(height: 60,),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is disposed
//     myFocusNode.dispose();
//     super.dispose();
//   }
//
//   Widget _getActionButtons() {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
//       child: new Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                     child: new Text("Save"),
//                     textColor: Colors.white,
//                     color: Colors.green,
//                     onPressed: () {
//                       setState(() {
//                         _status = true;
//                         FocusScope.of(context).requestFocus(new FocusNode());
//                       });
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20.0)),
//                   )),
//             ),
//             flex: 2,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                     child: new Text("Cancel"),
//                     textColor: Colors.white,
//                     color: Colors.red,
//                     onPressed: () {
//                       setState(() {
//                         _status = true;
//                         FocusScope.of(context).requestFocus(new FocusNode());
//                       });
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20.0)),
//                   )),
//             ),
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _getLogoutButtons() {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
//       child: new Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                     child: new Text("Log out"),
//                     textColor: Colors.white,
//                     color: Colors.red,
//                     onPressed: ()=> {
//                       AuthClass().signOut(),
//                       Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                       (route) => false),
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20.0)),
//                   )),
//             ),
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getEditIcon() {
//     return new GestureDetector(
//       child: new CircleAvatar(
//         backgroundColor: Colors.red,
//         radius: 14.0,
//         child: new Icon(
//           Icons.edit,
//           color: Colors.white,
//           size: 16.0,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           _status = false;
//         });
//       },
//     );
//   }
// }