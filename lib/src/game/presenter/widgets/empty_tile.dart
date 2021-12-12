import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

HexagonWidgetBuilder emptyTile(
  BuildContext context,
  Coordinates coordinates,
  BoxConstraints constraints,
) {
  return HexagonWidgetBuilder(
    padding: 4.0,
    cornerRadius: 8.0,
    elevation: 8,
    color: Theme.of(context).cardColor,
    child: Stack(
      alignment: Alignment.center,
      children: const [
        SizedBox.shrink(),
      ],
    ),
  );
}
