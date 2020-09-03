import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_base/phone/services.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  final User user;
  HomeScreen({this.title, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: const EdgeInsets.all(25.0),
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .apply(color: Colors.lightBlue))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: TextStyle(color: Colors.lightBlue, fontSize: 30),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "You logged in with : ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text("SignOut"),
              textColor: Colors.white,
              padding: EdgeInsets.all(16),
              onPressed: () {
                //code for sign out
                AuthService().signOut();
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
