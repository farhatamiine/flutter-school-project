import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<BottomNavyBarItem> itemsBar = [
  BottomNavyBarItem(
    icon: Icon(FontAwesomeIcons.vial),
    title: Text('API'),
    activeColor: Color(0xFF3f51b5),
    inactiveColor: Color(0xff9e9e9e),
  ),
  BottomNavyBarItem(
    icon: Icon(FontAwesomeIcons.globe),
    title: Text('MAP'),
    activeColor: Color(0xFF3f51b5),
    inactiveColor: Color(0xff9e9e9e),
  ),
  BottomNavyBarItem(
    icon: Icon(FontAwesomeIcons.brain),
    title: Text('AI'),
    activeColor: Color(0xFF3f51b5),
    inactiveColor: Color(0xff9e9e9e),
  ),
  BottomNavyBarItem(
    icon: Icon(FontAwesomeIcons.cog),
    title: Text('Setting'),
    activeColor: Color(0xFF3f51b5),
    inactiveColor: Color(0xff9e9e9e),
  ),
];
