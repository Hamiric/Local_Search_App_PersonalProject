import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double offsetY;

  CustomFloatingActionButtonLocation({required this.offsetY});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width / 2 -
        scaffoldGeometry.floatingActionButtonSize.width / 2;
    final double fabY = scaffoldGeometry.contentBottom - 
        scaffoldGeometry.floatingActionButtonSize.height - 
        scaffoldGeometry.minInsets.bottom - offsetY;

    return Offset(fabX, fabY);
  }
}
