import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/core/widgets/animated_fade_in_fade_out/animated_fade_in_fade_out.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/dialogs/dialogs.dart';
import 'package:hive_game_client/src/game/bloc/game_bloc.dart';
import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/models.dart';

class ArenaHivePage extends StatelessWidget {
  final String playerOne;
  final String playerTwo;

  static const routeName = '/';
  const ArenaHivePage({
    Key? key,
    required this.playerOne,
    required this.playerTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(
        playerOne,
        playerTwo,
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
  Insect? selectedInsect;
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
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const DedicatedAppBar(),
          backgroundColor: Theme.of(context).canvasColor,
          body: LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                  height: 75,
                  child: Stack(
                    children: [
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is! Player2Turn,
                        child: Builder(builder: (context) {
                          final _child = Container(
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.85),
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
                          if (state is Player2Turn) {
                            return _child;
                          } else {
                            return IgnorePointer(
                              child: _child,
                            );
                          }
                        }),
                      ),
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is Player2Turn,
                        shouldShrink: false,
                        child: Container(
                          height: 75,
                          color: Theme.of(context).backgroundColor,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            itemCount: state.player1Hand.length,
                            itemBuilder: (context, index) {
                              final _insect = state.player1Hand[index];
                              return HexagonWidget(
                                width: 60,
                                type: HexagonType.FLAT,
                                padding: 4.0,
                                cornerRadius: 8.0,
                                elevation: 8,
                                color: Theme.of(context).primaryColor,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (selectedInsect == _insect) {
                                          setState(() {
                                            selectedInsect = null;
                                          });
                                        } else {
                                          setState(() {
                                            selectedInsect = _insect;
                                            log('Selected insect is now $_insect');
                                          });
                                        }
                                      },
                                    ),
                                    Center(
                                      child: IgnorePointer(
                                        child: Icon(
                                          _insect.icon,
                                          size: 24,
                                          color: Theme.of(context).cardColor,
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
                                print(
                                    _coverRatio(constraint.biggest, childSize));
                                _transformationController.value =
                                    ((Matrix4.identity() *
                                        _coverRatio(
                                            constraint.biggest, childSize) *
                                        0.8) as Matrix4);
                              }
                            }
                          });
                          return HexagonGrid.pointy(
                            color: Theme.of(context).canvasColor,
                            depth: 5,
                            width: MediaQuery.of(context).size.height * 3,
                            buildTile: (coordinates) {
                              final _isPlayer1 = state.arena.player1Insects.any(
                                  (element) =>
                                      element.position?.x == coordinates.x &&
                                      element.position?.y == coordinates.y);
                              final _isPlayer2 = state.arena.player2Insects.any(
                                  (element) =>
                                      element.position?.x == coordinates.x &&
                                      element.position?.y == coordinates.y);
                              final Insect? _insect = _isPlayer1
                                  ? state.arena.player1Insects.firstWhere(
                                      (element) =>
                                          element.position?.x ==
                                              coordinates.x &&
                                          element.position?.y == coordinates.y)
                                  : _isPlayer2
                                      ? state.arena.player2Insects.firstWhere(
                                          (element) =>
                                              element.position?.x ==
                                                  coordinates.x &&
                                              element.position?.y ==
                                                  coordinates.y)
                                      : null;
                              final _isPossiblePositionForSelectInsect =
                                  selectedInsect?.possiblePositions.any(
                                        (element) =>
                                            element.x == coordinates.x &&
                                            element.y == coordinates.y,
                                      ) ??
                                      false;
                              final tileColor = _isPlayer1
                                  ? Theme.of(context).colorScheme.secondary
                                  : _isPlayer2
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor;
                              return HexagonWidgetBuilder(
                                padding: 4.0,
                                cornerRadius: 8.0,
                                elevation: 8,
                                color: _isPossiblePositionForSelectInsect
                                    ? Theme.of(context).canvasColor
                                    : tileColor,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (selectedInsect != null) {
                                          if (!(selectedInsect
                                                  ?.possiblePositions
                                                  .contains(Position(
                                                      coordinates.x,
                                                      coordinates.y)) ??
                                              true)) {
                                            showErrorDialog(
                                                context: context,
                                                title: 'Movimiento invalido',
                                                description:
                                                    'Este insecto no se puede mover a esta posicion');
                                          } else {
                                            context.read<GameBloc>().add(
                                                SetNewInsect(
                                                    selectedInsect!,
                                                    Position(coordinates.x,
                                                        coordinates.y)));
                                          }

                                          setState(() {
                                            selectedInsect = null;
                                            log('Selected insect is now $_insect');
                                          });
                                        } else {
                                          setState(() {
                                            selectedInsect = _insect;
                                            log('Selected insect is now $_insect');
                                          });
                                        }
                                      },
                                    ),
                                    IgnorePointer(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return (_insect != null)
                                              ? Icon(
                                                  _insect.icon,
                                                  size:
                                                      constraint.maxHeight / 10,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                )
                                              : Text(
                                                  '(${coordinates.x},${coordinates.y})',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 75,
                  color: Theme.of(context).backgroundColor,
                  child: Stack(
                    children: [
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is! Player1Turn,
                        shouldShrink: false,
                        child: Builder(builder: (context) {
                          final _child = Container(
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.85),
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
                          if (state is Player1Turn) {
                            return _child;
                          } else {
                            return IgnorePointer(
                              child: _child,
                            );
                          }
                        }),
                      ),
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is Player1Turn,
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
                            final _insect = state.player2Hand[index];
                            return HexagonWidget(
                              width: 60,
                              type: HexagonType.FLAT,
                              padding: 4.0,
                              cornerRadius: 8.0,
                              elevation: 8,
                              color: Theme.of(context).colorScheme.secondary,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (selectedInsect == _insect) {
                                        setState(() {
                                          selectedInsect = null;
                                        });
                                      } else {
                                        setState(() {
                                          selectedInsect = _insect;
                                          log('Selected insect is now $_insect');
                                        });
                                      }
                                    },
                                  ),
                                  Center(
                                    child: IgnorePointer(
                                      child: FaIcon(
                                        _insect.icon,
                                        size: 24,
                                        color: Theme.of(context).cardColor,
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
        );
      },
    );
  }
}
