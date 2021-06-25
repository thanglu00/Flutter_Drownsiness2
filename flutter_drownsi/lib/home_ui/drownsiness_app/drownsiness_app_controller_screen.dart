import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/tabIcon_data.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/profile_view/profile2_screen.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/ui_view/codeQR_view.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'drownsiness_app_theme.dart';
import 'home_view/my_home_screen.dart';

class DrownsinessAppHomeScreen extends StatefulWidget {
  final UserResponse userResponse;
  const DrownsinessAppHomeScreen({Key? key, required this.userResponse}) : super(key: key);

  @override
  _DrownsinessAppHomeScreenState createState() => _DrownsinessAppHomeScreenState();
}

class _DrownsinessAppHomeScreenState extends State<DrownsinessAppHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            setState(() {
              tabBody =
                  QRScreen(animationController: animationController);
            });
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ProfilePage(userResponse: widget.userResponse,);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
