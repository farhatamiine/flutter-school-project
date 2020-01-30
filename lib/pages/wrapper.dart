import 'package:Flutter_Showcase/Models/LoginModel.dart';
import 'package:Flutter_Showcase/pages/LoginPage.dart';
import 'package:Flutter_Showcase/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserRepository.instance(),
        child: Consumer(
          builder: (context, UserRepository user, _) {
            switch (user.status) {
              case Status.Uninitialized:
                return Splash();
              case Status.Unauthenticated:
              case Status.Authenticating:
                return LoginPage();
              case Status.Authenticated:
                return MainPage(user: user.user);
            }
          },
        ));
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xff013C93),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome To Flutter Showcase",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Image(
              image: AssetImage("assets/img/splash.jpg"),
            ),
            SizedBox(
              height: 30.0,
            ),
            SpinKitDualRing(
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Made by Amine Farhat",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
