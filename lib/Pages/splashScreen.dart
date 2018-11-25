import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> zoomin;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);

    zoomin = Tween(
      begin: 100.0,
      end: 1000.0,
    ).animate(
     _controller
    );

    zoomin.addListener(() {
      setState(() {});
    });

    zoomin.addStatusListener((status){
      if(status==AnimationStatus.completed){
        _controller.reverse();
      }else if(status==AnimationStatus.dismissed){
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2),
              Color(0xFF4A00E0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/keshaa-final.png',
                width: zoomin.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
