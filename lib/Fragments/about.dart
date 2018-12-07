import 'package:flutter/material.dart';

class About extends StatefulWidget {
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Widget buildAbout() {
    return Container(
     child: Center(
       child: Text('Inside About Page'),
     ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAbout();
  }
}
