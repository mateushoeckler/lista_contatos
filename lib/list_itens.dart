import 'dart:ui';

import 'package:flutter/material.dart';

import 'item_transformado.dart';

class ListItens extends StatelessWidget {

  final int generatedItems;
  final int currentIndex;
  final double heightItem;
  final double pagePercent;
  final List<Widget> children;

  const ListItens({super.key, required this.generatedItems, required this.currentIndex, required this.heightItem, required this.pagePercent, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        final height = constraints.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: List.generate(generatedItems, (index){
            final invertedIndex = generatedItems - 2 - index;
            final indexPlus = index + 1;
            final positionPercent = indexPlus / generatedItems;
            final endPositonPercent = index / generatedItems;
            return currentIndex > invertedIndex ? ItemTransformado(
              heightItem: heightItem,
              factorChange: pagePercent,
              scale: lerpDouble(0.5, 1, positionPercent)!,
              endScale: lerpDouble(0.5, 1, endPositonPercent)!,
              translateY: (height - heightItem) * positionPercent,
              endTranslateY: (height - heightItem) * endPositonPercent,
              child: children[currentIndex - invertedIndex - 1]
            ): Container();
          })..insert(0, currentIndex > generatedItems - 1 ? ItemTransformado(
                heightItem: heightItem,
                factorChange: 1.0,
                endScale: 0.5,
                child: children[currentIndex - generatedItems]
            ): Container()),
        );
      }
    );
  }
}
