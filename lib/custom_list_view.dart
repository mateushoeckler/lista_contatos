import 'package:flutter/material.dart';

import 'card_contato.dart';
import 'contato.dart';
import 'list_itens.dart';

class CustomListView extends StatefulWidget {

  final List<Widget> children;
  final double itemExtent;
  final int visualizedItems;
  final int initialIndex;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int>? onTapFrontItem;
  final ValueChanged<int>? onChangedItem;
  final Color backItemsShadowColor;

  const CustomListView({
    required this.children,
    required this.itemExtent,
    required this.visualizedItems,
    this.initialIndex = 0,
    this.padding = EdgeInsets.zero,
    this.onTapFrontItem,
    this.onChangedItem,
    this.backItemsShadowColor = Colors.black
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {

  late PageController _pageController;
  late double _pagePercent;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1 / widget.visualizedItems
    );
    _currentIndex = widget.initialIndex;
    _pagePercent = 0;
    _pageController.addListener(_pageListener);
  }

  void _pageListener(){
    _currentIndex = _pageController.page!.floor();
    _pagePercent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          children: [
            Padding(
              padding: widget.padding,
              child: ListItens(
                generatedItems: widget.visualizedItems - 1,
                currentIndex: _currentIndex,
                heightItem: widget.itemExtent,
                pagePercent: _pagePercent,
                children: widget.children
              ),
            ),
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (value){
                if(widget.onChangedItem != null){
                  widget.onChangedItem!(value);
                }
              },
              itemCount: widget.children.length,
              itemBuilder: (context, index){
                return SizedBox();
              },
            ),
            Positioned.fill(
              top: height - widget.itemExtent,
              child: GestureDetector(
                onTap: (){
                  if(widget.onTapFrontItem != null){
                    widget.onTapFrontItem!(_currentIndex);
                  }
                },
              ),
            )
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }
}
