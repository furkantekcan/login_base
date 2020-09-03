import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_base/phone/services.dart';

class PhoneLoginScreen extends StatefulWidget {
  PhoneLoginScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter phone number'),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                  )),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter OTP'),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ))
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: FlatButton(
                      child: codeSent ? Text('Login') : Text('Verify'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        codeSent
                            ? AuthService()
                                .signInWithOTP(smsCode, verificationId)
                            : verifyPhone(phoneNo);
                      }))
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
