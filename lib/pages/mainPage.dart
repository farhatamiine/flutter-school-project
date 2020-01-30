import 'package:TripPlanner/pages/Ai.dart';
import 'package:TripPlanner/pages/HomePage.dart';
import 'package:TripPlanner/pages/Map.dart';
import 'package:TripPlanner/pages/settingPage.dart';
import 'package:TripPlanner/utils/bottomNavigationItem.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final FirebaseUser user;

  const MainPage({Key key, this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) {
          bottomTapped(index);
        },
        currentIndex: _currentIndex,
        items: itemsBar,
      ),
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  @override
  void initState() {
    super.initState();
  }

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      pageSnapping: true,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        ApiPage(),
        MapPage(),
        AiPage(),
        SettingPage(user: widget.user)
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      this._currentIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 1), curve: Curves.ease);
    });
  }
}
