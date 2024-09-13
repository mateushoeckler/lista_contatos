import 'dart:ui';

import 'package:flutter/material.dart';

class ItemTransformado extends StatelessWidget {

  final Widget child;
  final double heightItem;
  final double factorChange;
  final double scale;
  final double endScale;
  final double translateY;
  final double endTranslateY;

  const ItemTransformado({
    super.key,
    required this.child,
    required this.heightItem,
    required this.factorChange,
    this.scale = 1,
    this.endScale = 0.0,
    this.translateY = 0.0,
    this.endTranslateY = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
         ..scale(lerpDouble(scale, endScale, factorChange))
         ..translate(0.0, lerpDouble(translateY, endTranslateY, factorChange)!, 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: heightItem,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
