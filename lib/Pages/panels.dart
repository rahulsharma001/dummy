import 'package:flutter/material.dart';
import 'package:keshaa_android/Fragments/gallery.dart';
import 'package:keshaa_android/Pages/backlayer.dart';
import 'package:keshaa_android/Pages/frontlayer.dart';

class PanelClass extends StatefulWidget {
  Animation controller;
  final Widget frontLayer;
  final Widget backLayer;
  final String frontLayerText;
  PanelClass(
      {this.controller, this.frontLayer, this.backLayer, this.frontLayerText});

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
          Center(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF000000),
                    Color(0xFF2D3436),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: ExcludeSemantics(
                  child: BackLayer(
                      controller: widget.controller, child: widget.backLayer),
                )),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child:
                Material(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              child: Column(
                children: <Widget>[
                  widget.controller.isDismissed
                      ? Container(
                          padding: EdgeInsets.only(top: 8.0),
                          height: header_height,
                          child: widget.frontLayerText != null
                              ? Text(widget.frontLayerText,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500))
                              : Text('Gallery', style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500)),
                        )
                      : Container(),
                  Expanded(
                    // child: Container(
                    //   child: Center(
                    //     child: Text('Worked'),
                    //   ),
                    // ),)
                    child: FrontLayer(
                        child: widget.frontLayer == null
                            ? GalleryGrid()
                            : widget.frontLayer),
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
