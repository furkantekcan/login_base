import 'package:flutter/material.dart';
import 'package:login_base/ui/screens/home.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: Theme.of(context).iconTheme,
            title: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.title,
                    style: Theme.of(context).textTheme.headline4)),
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
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: '0 53',
                      labelText: 'Phone number *',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.length == 11 ? null : 'Check phone number';
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: MaterialButton(
                      child: Text(
                        'Verify',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    title: 'Home',
                                  )),
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
