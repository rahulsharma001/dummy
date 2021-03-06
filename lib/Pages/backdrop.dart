import 'package:flutter/material.dart';
import 'package:keshaa_android/Pages/panels.dart';

class BackDrop extends StatefulWidget {
  final Widget backlayer;
  final Widget frontlayer;
  final String frontLayerText;

  BackDrop({this.backlayer, this.frontlayer, this.frontLayerText});

  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this, value: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: widget.frontLayerText != null
            ? Text(widget.frontLayerText)
            : Text('Gallery'),
        leading: IconButton(
          onPressed: () {
            controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
          },
          icon: AnimatedIcon(
            progress: controller.view,
            icon: AnimatedIcons.close_menu,
          ),
        ),
      ),
      body: PanelClass(
          controller: controller,
          frontLayer: widget.frontlayer,
          backLayer: widget.backlayer,
          frontLayerText: widget.frontLayerText),
    );
  }
}
