import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/presenter/widgets/show_insect_data.dart';

import 'package:provider/src/provider.dart';

HexagonWidgetBuilder buildPlayer2Tile(
  BuildContext context,
  Insect _insect,
  Coordinates coordinates,
  BoxConstraints constraints,
) {
  return HexagonWidgetBuilder(
    padding: 4.0,
    cornerRadius: 8.0,
    elevation: 8,
    color: Theme.of(context).primaryColor,
    child: Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onLongPress: () => showInsectData(context, _insect),
          onDoubleTap: () => showInsectData(context, _insect),
          onTap: () {},
        ),
        IgnorePointer(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: constraints,
                child: Image.asset(
                  'assets/images/${_insect.type}.png',
                  height: MediaQuery.of(context).size.height / 7,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
