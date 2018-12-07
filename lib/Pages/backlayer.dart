import 'package:flutter/material.dart';
import 'package:keshaa_android/Fragments/gallery.dart';
import 'package:keshaa_android/Fragments/products.dart';
import 'package:keshaa_android/Pages/backdrop.dart';
import 'package:keshaa_android/Fragments/contact.dart';


class BackLayer extends StatefulWidget {
  final AnimationController controller;
  final Widget child;
  BackLayer({this.controller, this.child});

  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  List<String> navlist = ['Gallery', 'Products', 'Contact Us'];
  bool get isPanelVisible {
    final AnimationStatus status = widget.controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  _navigateToFrontLayer(Widget frontlayer,int index) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BackDrop(frontlayer: frontlayer,frontLayerText: navlist[index],),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: navlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      _navigateToFrontLayer(GalleryGrid(),index);
                      break;
                    case 1:
                      _navigateToFrontLayer(ProductGrid(),index);
                      break;
                      case 2:
                      _navigateToFrontLayer(ContactPage(), index);
                      break;
                  }
                  // print(navlist[index].toString());

                  widget.controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
                },
                title: Text(
                  navlist[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFDAA520), fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
