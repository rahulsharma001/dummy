import 'package:flutter/material.dart';
import 'package:keshaa_android/Pages/backlayer.dart';
import 'package:keshaa_android/Pages/frontlayer.dart';

class PanelClass extends StatefulWidget {
  Animation controller;
  final Widget frontLayer;
  final Widget backLayer;
  PanelClass({this.controller, this.frontLayer, this.backLayer});

  _PanelClassState createState() => _PanelClassState();
}

class _PanelClassState extends State<PanelClass> {
  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backpanel_height = height - header_height;
    final frontpanel_height = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backpanel_height, 0.0, frontpanel_height),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  static const header_height = 32.0;
  Widget buildBothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              color: Theme.of(context).accentColor,
              // child: Center(
              //   child: RaisedButton(
              //     child: Text('About'),
              //     onPressed: () {
              //       TestingClass();
              //     },
              //   ),
              // ),
              child: ExcludeSemantics(
                child: BackLayer(
                  controller: widget.controller,
                ),
              )),
          // child0,
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child:
                //  Material(
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(16.0),
                //     topRight: Radius.circular(16.0),
                //   ),
                Material(
              // elevation: 16.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: <Widget>[
                  widget.controller.isDismissed
                      ? Container(
                          height: header_height,
                          child: Text('Gallery'),
                        )
                      : Container(),
                  Expanded(
                    // child: Container(
                    //   child: Center(
                    //     child: Text('Worked'),
                    //   ),
                    // ),)
                    child: FrontLayer(child: widget.frontLayer),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: buildBothPanels,
    );
  }
}
