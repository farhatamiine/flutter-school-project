import 'package:TripPlanner/Models/LoginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/login.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  style: TextStyle(color: Color(0xff013C93), fontSize: 20.0),
                  controller: _email,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Email" : null,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Color(0xff013C93)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Color(0xff013C93)),
                      ),
                      labelStyle: new TextStyle(color: Color(0xff013C93)),
                      prefixIcon: Icon(
                        FontAwesomeIcons.addressBook,
                        color: Color(0xff013C93),
                      ),
                      labelText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _password,
                  style: TextStyle(color: Color(0xff013C93), fontSize: 20.0),
                  obscureText: true,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Password" : null,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Color(0xff013C93)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Color(0xff013C93)),
                      ),
                      labelStyle: new TextStyle(color: Color(0xff013C93)),
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: Color(0xff013C93),
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder()),
                ),
              ),
              user.status == Status.Authenticating
                  ? Center(
                      child: SpinKitCubeGrid(
                      size: 20,
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 0.5,
                        borderRadius: BorderRadius.circular(3.0),
                        color: Color(0xFF181241),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (_formKey.currentState.validate()) {
                                if (!await user.signIn(
                                    _email.text, _password.text))
                                  _key.currentState.showSnackBar(SnackBar(
                                    content: Text("Something is wrong"),
                                  ));
                              }
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: style.copyWith(
                                color: Color(0xFFfafafa),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
