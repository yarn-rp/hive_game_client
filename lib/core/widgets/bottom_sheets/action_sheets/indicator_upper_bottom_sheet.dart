import 'package:flutter/material.dart';

class IndicatorUpperBottomSheet extends StatelessWidget {
  const IndicatorUpperBottomSheet({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.width = 40,
    this.height = 3.5,
    this.color,
  }) : super(key: key);

  final Color? color;
  final double height;
  final EdgeInsets padding;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
