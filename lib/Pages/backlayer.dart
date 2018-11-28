import 'package:flutter/material.dart';
import 'package:keshaa_android/Pages/panels.dart';

class BackLayer extends StatefulWidget {
  AnimationController controller;
  Widget child;
  BackLayer({this.controller});

  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  var _currentPageIndex;
  List<String> navlist = ['Home', 'About', 'Contact Us'];
  bool get isPanelVisible {
    final AnimationStatus status = widget.controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: navlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              onTap: () {
                setState(() {
                  _currentPageIndex = navlist[index];
                });
                // PanelClass(frontLayer: About(),);
                print(navlist[index].toString());

                widget.controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
              },
              title: Text(
                navlist[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
}
