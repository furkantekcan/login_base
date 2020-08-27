import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: CupertinoActivityIndicator(
          radius: 20.0,
        ),
      ),
    );
  }
}
