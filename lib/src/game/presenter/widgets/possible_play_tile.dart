import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/presenter/widgets/show_insect_data.dart';
import 'package:hive_game_client/src/game/state_management/player_vs_player_bloc/game_bloc.dart';
import 'package:provider/src/provider.dart';

HexagonWidgetBuilder possiblePlayTile(
  BuildContext context,
  Insect _insect,
  Insect? _currentInsect,
  Coordinates coordinates,
  BoxConstraints constraints,
) {
  return HexagonWidgetBuilder(
    padding: 4.0,
    cornerRadius: 8.0,
    elevation: 8,
    color: CupertinoColors.systemGrey,
    child: Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onLongPress: () => showInsectData(context, _insect),
          onDoubleTap: () => showInsectData(context, _insect),
          onTap: () {
            if (_insect.position == null) {
              context.read<GamePvsPBloc>().add(
                    SetNewInsect(
                      _insect,
                      Position(coordinates.x, coordinates.y),
                    ),
                  );
            } else {
              if (_currentInsect != null) {
                log('Ya habia un icho con level : ${_currentInsect.level}');
              }
              context.read<GamePvsPBloc>().add(
                    ChangeInsectPosition(
                      _insect,
                      Position(coordinates.x, coordinates.y),
                      _currentInsect != null ? _currentInsect.level : 0,
                    ),
                  );
            }
          },
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
                  color: CupertinoColors.systemGrey4,
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
