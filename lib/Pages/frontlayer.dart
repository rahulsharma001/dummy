import 'package:flutter/material.dart';
import 'package:keshaa_android/Pages/panels.dart';

class FrontLayer extends StatelessWidget {
  // TODO: Add on-tap callback (104)
  const FrontLayer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   elevation: 16.0,
    //   shape: BeveledRectangleBorder(
    //     borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
    //   ),
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // TODO: Add a GestureDetector (104)
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
