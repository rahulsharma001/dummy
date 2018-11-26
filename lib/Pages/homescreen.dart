import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _fractionOffset;
  double width;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   width = MediaQuery.of(context).size.width;
    // });

    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _fractionOffset = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.addListener(() {
      setState(() {});
    });

    // _controller.forward();
  }

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      _controller.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: GestureDetector(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: Icon(Icons.menu),
        ),
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          Positioned(

            width: MediaQuery.of(context).size.width,
            // right: MediaQuery.of(context).size.width,
            child: SlideTransition(
              position: _fractionOffset,
              textDirection: TextDirection.ltr,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.red),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('Home')],
                ),
              ),
            ),
          ),
          Center(
            child:FlatButton(
              color: Colors.blue,
              onPressed: () {
              },
              child: Text('Drawer'),
            ),
          ),
        ],
      ),),
    );
  }
}
