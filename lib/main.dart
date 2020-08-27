import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_base/ui/screens/home.dart';
import 'package:login_base/ui/screens/loading.dart';
import 'package:login_base/ui/screens/login_page.dart';
import 'package:login_base/ui/screens/phone_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          print('Something went wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('Done :)');
          return MaterialApp(
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => new LoginScreen(),
              '/phoneLogin': (BuildContext context) => new PhoneLoginScreen(),
              '/home': (BuildContext context) => new HomeScreen(),
            },
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginScreen(title: 'Login'),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

/*
MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(title: 'Login'),
    );
*/
