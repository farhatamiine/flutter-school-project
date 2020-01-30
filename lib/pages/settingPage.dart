import 'package:Flutter_Showcase/Models/LoginModel.dart';
import 'package:Flutter_Showcase/utils/theme.dart';
import 'package:Flutter_Showcase/utils/themeNotifer.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  FirebaseUser user;
  SettingPage({Key key, this.user}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final user = Provider.of<UserRepository>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.settings),
        title: Text("Setting"),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.format_paint),
            title: Text('Dark Theme'),
            contentPadding: const EdgeInsets.only(left: 16.0),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitch(
                value: _darkTheme,
                onChanged: (val) {
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          ),
          Ink(
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () => print("Hey"),
              contentPadding: const EdgeInsets.only(left: 16.0),
            ),
          ),
          Ink(
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () => print("Language"),
              contentPadding: const EdgeInsets.only(left: 16.0),
            ),
          ),
          Ink(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text(widget.user.email),
              onTap: () => print("About"),
              contentPadding: const EdgeInsets.only(left: 16.0),
            ),
          ),
          Ink(
            child: ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () => user.signOut(),
              contentPadding: const EdgeInsets.only(left: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
  }
}
