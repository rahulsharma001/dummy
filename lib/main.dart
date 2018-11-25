import 'package:flutter/material.dart';
import './Pages/splashScreen.dart';

main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFFFDF00)
      ),
      routes: {
        '/':(BuildContext context)=>SplashScreen()
      },
    );
  }
}