import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/core/widgets/animated_fade_in_fade_out/animated_fade_in_fade_out.dart';
import 'package:hive_game_client/core/widgets/bottom_sheets/action_sheets/indicator_upper_bottom_sheet.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/dialogs/dialogs.dart';
import 'package:hive_game_client/main.dart';

import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/presenter/widgets/empty_tile.dart';
import 'package:hive_game_client/src/game/presenter/widgets/player_1_tile.dart';
import 'package:hive_game_client/src/game/presenter/widgets/player_2_tile.dart';
import 'package:hive_game_client/src/game/presenter/widgets/possible_play_tile.dart';
import 'package:hive_game_client/src/game/presenter/widgets/show_insect_data.dart';
import 'package:hive_game_client/src/game/state_management/player_vs_player_bloc/game_bloc.dart';

class ArenaPvsPPage extends StatelessWidget {
  final String playerOne;
  final String playerTwo;

  static const routeName = '/arena-hive/p-vs-p';

  const ArenaPvsPPage({
    Key? key,
    required this.playerOne,
    required this.playerTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('arena PvsP with $playerOne vs $playerTwo');
    return BlocProvider(
      create: (context) => sl<GamePvsPBloc>(
        param1: playerOne,
        param2: playerTwo,
      ),
      child: ArenaHiveView(
        playerOne: playerOne,
        playerTwo: playerTwo,
      ),
    );
  }
}

class ArenaHiveView extends StatefulWidget {
  final String playerOne;
  final String playerTwo;

  const ArenaHiveView({
    Key? key,
    required this.playerOne,
    required this.playerTwo,
  }) : super(key: key);

  @override
  State<ArenaHiveView> createState() => _ArenaHiveViewState();
}

class _ArenaHiveViewState extends State<ArenaHiveView> {
  late TransformationController _transformationController;
  int depth = 5;
  bool loaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transformationController =
        TransformationController(Matrix4.identity() * 0.1);
  }

  double _coverRatio(Size outside, Size inside) {
    if (outside.width / outside.height > inside.width / inside.height) {
      return outside.width / inside.width;
    } else {
      return outside.height / inside.height;
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GamePvsPBloc, GamePvsPState>(
      listener: (context, state) {
        if (state.failure != null) {
          showErrorDialog(
            context: context,
            title: 'Error',
            description: state.failure.toString(),
          );
        }
        if (state.arena.player1.gameOver) {
          showErrorDialog(
              context: context,
              title: 'Game Over',
              description: 'Player 1, you lost. LOOOOSSSEEERRRR');
          Navigator.pop(context);
        }
        if (state.arena.player2.gameOver) {
          showErrorDialog(
              context: context,
              title: 'Game Over',
              description: 'Player 2, you lost. LOOOOSSSEEERRRR');
          Navigator.pop(context);
        }
        if (state.arena.insects.any((element) {
          return (element.position!.x).abs() > depth - 2 ||
              (element.position!.y).abs() > depth - 2;
        })) {
          setState(() {
            depth = depth * 2;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: DedicatedAppBar(
            centerTitle: true,
            title: Text('${widget.playerOne} vs ${widget.playerTwo}'),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: LayoutBuilder(builder: (context, constraint) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: Stack(
                      children: [
                        AnimatedFadeInFadeOut(
                          shouldShow: () => state.arena.currentPlayerId == 'p1',
                          child: Builder(builder: (context) {
                            final _child = Container(
                              color: Theme.of(context).backgroundColor,
                              child: Center(
                                child: Text(
                                  'Wait for your oponents move',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                            );
                            if (state.arena.currentPlayerId != 'p1') {
                              return _child;
                            } else {
                              return IgnorePointer(
                                child: _child,
                              );
                            }
                          }),
                        ),
                        AnimatedFadeInFadeOut(
                          shouldShow: () => state.arena.currentPlayerId != 'p1',
                          shouldShrink: false,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 10,
                            color: Theme.of(context).backgroundColor,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              itemCount: state.player2Hand.length,
                              itemBuilder: (context, index) {
                                final _insect = state.player2Hand[index];
                                return HexagonWidget(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  type: HexagonType.FLAT,
                                  padding: 4.0,
                                  cornerRadius: 8.0,
                                  elevation: 8,
                                  color: Theme.of(context).primaryColor,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                        onLongPress: () =>
                                            showInsectData(context, _insect),
                                        onDoubleTap: () =>
                                            showInsectData(context, _insect),
                                        onTap: () {
                                          if (state.insectSelectedData !=
                                              null) {
                                          } else {
                                            context.read<GamePvsPBloc>().add(
                                                GetPossiblePlacements(_insect));
                                          }
                                        },
                                      ),
                                      Center(
                                        child: IgnorePointer(
                                          child: Image.asset(
                                            'assets/images/${_insect.type}.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.arena.player1.numberOfMoves.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          Text(' : ',
                              style: Theme.of(context).textTheme.headline4),
                          Text(
                            state.arena.player2.numberOfMoves.toString(),
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: InteractiveViewer(
                        transformationController: _transformationController,
                        minScale: 0.1,
                        maxScale: 1,
                        constrained: false,
                        child: Builder(
                          builder: (context) {
                            WidgetsBinding.instance
                                ?.addPostFrameCallback((timeStamp) {
                              if (!loaded) {
                                loaded = true;
                                final renderBox =
                                    context.findRenderObject() as RenderBox?;
                                final childSize = renderBox?.size ?? Size.zero;
                                if (childSize != Size.zero) {
                                  print(_coverRatio(
                                      constraint.biggest, childSize));
                                  _transformationController.value =
                                      ((Matrix4.identity() *
                                          _coverRatio(
                                              constraint.biggest, childSize) *
                                          0.8) as Matrix4);
                                }
                              }
                            });
                            return Padding(
                              padding: const EdgeInsets.all(80.0),
                              child: HexagonGrid.pointy(
                                color: Theme.of(context).backgroundColor,
                                depth: depth,
                                width: MediaQuery.of(context).size.height * 3,
                                buildTile: (coordinates) {
                                  final Insect? _insect = state.arena.insects
                                          .any((element) =>
                                              element.position?.x ==
                                                  coordinates.x &&
                                              element.position?.y ==
                                                  coordinates.y)
                                      ? state.arena.insects.firstWhere(
                                          (element) =>
                                              element.position?.x ==
                                                  coordinates.x &&
                                              element.position?.y ==
                                                  coordinates.y,
                                        )
                                      : null;
                                  bool _isPlayer1 = false;
                                  bool _isPlayer2 = false;
                                  if (_insect != null) {
                                    _isPlayer1 = _insect.playerId == 'p1';
                                    _isPlayer2 = _insect.playerId == 'p2';
                                  }
                                  final _isPossiblePositionForSelectInsect =
                                      state.insectSelectedData != null &&
                                          state.insectSelectedData!.second.any(
                                            (element) =>
                                                element.x == coordinates.x &&
                                                element.y == coordinates.y,
                                          );

                                  if (_isPossiblePositionForSelectInsect) {
                                    return possiblePlayTile(
                                      context,
                                      state.insectSelectedData!.first,
                                      _insect,
                                      coordinates,
                                      constraint,
                                    );
                                  } else if (_insect != null && _isPlayer1) {
                                    return buildPlayer1Tile(context, _insect,
                                        coordinates, constraint);
                                  } else if (_insect != null && _isPlayer2) {
                                    return buildPlayer2Tile(context, _insect,
                                        coordinates, constraint);
                                  } else {
                                    return emptyTile(
                                        context, coordinates, constraint);
                                  }

                                  // return HexagonWidgetBuilder(
                                  //   padding: 4.0,
                                  //   cornerRadius: 8.0,
                                  //   elevation: 8,
                                  //   color: _isPossiblePositionForSelectInsect
                                  //       ? CupertinoColors.systemGrey
                                  //       : tileColor,
                                  //   child: Stack(
                                  //     alignment: Alignment.center,
                                  //     children: [
                                  //       GestureDetector(
                                  //         onLongPress: () => _insect != null
                                  //             ? showInsectData(context, _insect)
                                  //             : null,
                                  //         onDoubleTap: () => _insect != null
                                  //             ? showInsectData(context, _insect)
                                  //             : null,
                                  //         onTap: () {
                                  //           if (state.insectSelectedData !=
                                  //               null) {
                                  //             if (!(true)) {
                                  //             } else {
                                  //               log('dile al bloc q añada un uevo insecto');
                                  //               context
                                  //                   .read<GamePvsPBloc>()
                                  //                   .add(SetNewInsect(
                                  //                       state
                                  //                           .insectSelectedData!
                                  //                           .first,
                                  //                       Position(coordinates.x,
                                  //                           coordinates.y)));
                                  //             }

                                  //             // setState(() {
                                  //             //   selectedInsect = null;
                                  //             //   log('Selected insect is now $_insect');
                                  //             // });
                                  //           } else {
                                  //             // setState(() {
                                  //             //   selectedInsect = _insect;
                                  //             //   log('Selected insect is now $_insect');
                                  //             // });
                                  //             if (_insect != null) {
                                  //               context
                                  //                   .read<GamePvsPBloc>()
                                  //                   .add(
                                  //                     GetPossibleMovements(
                                  //                       _insect,
                                  //                       Position(
                                  //                         coordinates.x,
                                  //                         coordinates.y,
                                  //                       ),
                                  //                     ),
                                  //                   );
                                  //             }
                                  //           }
                                  //         },
                                  //       ),
                                  //       IgnorePointer(
                                  //         child: LayoutBuilder(
                                  //           builder: (context, constraints) {
                                  //             return (_insect != null)
                                  //                 ? Container(
                                  //                     constraints: constraint,
                                  //                     child: Image.asset(
                                  //                       'assets/images/${_insect.type}.png',
                                  //                       height: MediaQuery.of(
                                  //                                   context)
                                  //                               .size
                                  //                               .height /
                                  //                           7,
                                  //                       fit: BoxFit.cover,
                                  //                     ),
                                  //                   )
                                  //                 : _isPossiblePositionForSelectInsect
                                  //                     ? Container(
                                  //                         constraints:
                                  //                             constraint,
                                  //                         child: Image.asset(
                                  //                           'assets/images/${state.insectSelectedData!.first.type}.png',
                                  //                           height: MediaQuery.of(
                                  //                                       context)
                                  //                                   .size
                                  //                                   .height /
                                  //                               7,
                                  //                           fit: BoxFit.cover,
                                  //                           color:
                                  //                               CupertinoColors
                                  //                                   .systemGrey4,
                                  //                         ),
                                  //                       )
                                  //                     : const SizedBox.shrink();
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    color: Theme.of(context).backgroundColor,
                    child: Stack(
                      children: [
                        AnimatedFadeInFadeOut(
                          shouldShow: () => state.arena.currentPlayerId == 'p2',
                          shouldShrink: false,
                          child: Builder(builder: (context) {
                            final _child = Container(
                              color: Theme.of(context).backgroundColor,
                              child: Center(
                                child: Text(
                                  'Wait for your oponents move',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                              ),
                            );
                            if (state.arena.currentPlayerId == 'p2') {
                              return _child;
                            } else {
                              return IgnorePointer(
                                child: _child,
                              );
                            }
                          }),
                        ),
                        AnimatedFadeInFadeOut(
                          shouldShow: () => state.arena.currentPlayerId != 'p2',
                          shouldShrink: false,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            itemCount: state.player2Hand.length,
                            itemBuilder: (context, index) {
                              final _insect = state.player1Hand[index];
                              return HexagonWidget(
                                width: MediaQuery.of(context).size.height / 12,
                                type: HexagonType.FLAT,
                                padding: 4.0,
                                cornerRadius: 8.0,
                                elevation: 8,
                                color: Theme.of(context).colorScheme.secondary,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onLongPress: () =>
                                          showInsectData(context, _insect),
                                      onDoubleTap: () =>
                                          showInsectData(context, _insect),
                                      onTap: () {
                                        if (state.insectSelectedData?.first ==
                                            _insect) {
                                          // setState(() {
                                          //   selectedInsect = null;
                                          // });
                                        } else {
                                          context.read<GamePvsPBloc>().add(
                                              GetPossiblePlacements(_insect));
                                          // setState(() {
                                          //   selectedInsect = _insect;
                                          //   log('Selected insect is now $_insect');
                                          // });
                                        }
                                      },
                                    ),
                                    Center(
                                      child: IgnorePointer(
                                        child: Image.asset(
                                          'assets/images/${_insect.type}.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              24,
                                          // color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
