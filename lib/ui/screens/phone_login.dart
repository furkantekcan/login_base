import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_base/ui/screens/home.dart';
//import 'package:login_base/ui/screens/verify.dart';

class PhoneLoginScreen extends StatefulWidget {
  PhoneLoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();

  final _passController = TextEditingController();

  Future initializeApp() async {
    await Firebase.initializeApp();
    FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Somthing gone wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen(
            title: 'Home',
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: Theme.of(context).iconTheme,
          title: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .apply(color: Colors.lightBlue))),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone Number"),
                  controller: _phoneController,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Password"),
                  controller: _passController,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  title: 'Home',
                                )),
                      );

                      */

                      final mobile = _phoneController.text.trim();
                      registerUser(mobile, context);
                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
