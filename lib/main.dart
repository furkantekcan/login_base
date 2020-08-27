import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_base/ui/screens/loading.dart';
import 'package:login_base/ui/screens/login_page.dart';

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
