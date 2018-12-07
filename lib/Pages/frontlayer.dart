import 'package:flutter/material.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
