import 'package:flutter/material.dart';
import 'package:login_base/ui/screens/home.dart';
import 'package:login_base/ui/screens/phone_login.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
                padding: const EdgeInsets.all(50.0),
                child: Text(widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(color: Colors.lightBlue))),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Phone Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneLoginScreen(
                                  title: 'Phone Login',
                                )),
                      );
                    },
                    color: Colors.blue,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Google Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  title: 'Home',
                                )),
                      );
                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
