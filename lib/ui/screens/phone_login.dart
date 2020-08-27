import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code

        TextEditingController _codeController;

        String smsCode = 'xxxx';

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Enter SMS code'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Done"),
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        smsCode = _codeController.toString();

                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                        auth
                            .signInWithCredential(credential)
                            .then((UserCredential result) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        user: result.user,
                                      )));
                        }).catchError((e) {
                          print(e);
                        });
/*
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      user: auth.currentUser,
                                      title: 'Home',
                                    )));

*/
                      },
                    )
                  ],
                ));
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timout");
      },
    );
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
                  keyboardType: TextInputType.phone,
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
                      //code for sign in
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
