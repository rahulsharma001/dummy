import 'package:flutter/material.dart';
import 'package:keshaa_android/Fragments/gallery.dart';
import 'package:keshaa_android/Fragments/products.dart';
import 'package:keshaa_android/Pages/backdrop.dart';
import 'package:keshaa_android/Pages/panels.dart';

class BackLayer extends StatefulWidget {
  AnimationController controller;
  Widget child;
  BackLayer({this.controller, this.child});

  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  var _currentPageIndex;
  List<String> navlist = ['Gallery', 'Products', 'Contact Us'];
  bool get isPanelVisible {
    final AnimationStatus status = widget.controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  _navigateToFrontLayer(Widget frontlayer) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BackDrop(frontlayer: frontlayer),
      ),
    );
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
                  print(index);
                });
                switch (index) {
                  case 0:
                    _navigateToFrontLayer(GalleryGrid());
                    break;
                  case 1:
                    _navigateToFrontLayer(ProductGrid());
                    break;
                }
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
