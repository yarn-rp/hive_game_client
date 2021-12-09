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

import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/state_management/player_vs_player_bloc/game_bloc.dart';

class ArenaPvsPPage extends StatelessWidget {
  final String playerOne;
  final String playerTwo;

  static const routeName = '/arena-hive/pvsp';

  const ArenaPvsPPage({
    Key? key,
    required this.playerOne,
    required this.playerTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('arena PvsP with $playerOne vs $playerTwo');
    return BlocProvider(
      create: (context) => GamePvsPBloc(
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

  Future<void> showInsectData(Insect insect) => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          constraints: BoxConstraints(maxWidth: 360),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IndicatorUpperBottomSheet(
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    color: Theme.of(context).dividerColor,
                  ),
                  HexagonWidget(
                    width: 100,
                    type: HexagonType.FLAT,
                    padding: 4.0,
                    cornerRadius: 8.0,
                    elevation: 8,
                    color: Theme.of(context).dividerColor,
                    child: Center(
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/images/${insect.icon}.png',
                          height: 60,
                          // color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    insect.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Aqui va un texto de descripcion de lo que hace la carta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GamePvsPBloc, GamePvsPState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: DedicatedAppBar(
            centerTitle: true,
            title: Text('${widget.playerOne} vs ${widget.playerTwo}'),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Stack(
                    children: [
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is! Player2Turn,
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
                          height: MediaQuery.of(context).size.height / 10,
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
                                height: MediaQuery.of(context).size.height / 12,
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
                                          showInsectData(_insect),
                                      onDoubleTap: () =>
                                          showInsectData(_insect),
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
                                        child: Image.asset(
                                          'assets/images/${_insect.icon}.png',
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
                          return Padding(
                            padding: const EdgeInsets.all(80.0),
                            child: HexagonGrid.pointy(
                              color: Theme.of(context).backgroundColor,
                              depth: 5,
                              width: MediaQuery.of(context).size.height * 3,
                              buildTile: (coordinates) {
                                final _isPlayer1 = state.arena.player1Insects
                                    .any((element) =>
                                        element.position?.x == coordinates.x &&
                                        element.position?.y == coordinates.y);
                                final _isPlayer2 = state.arena.player2Insects
                                    .any((element) =>
                                        element.position?.x == coordinates.x &&
                                        element.position?.y == coordinates.y);
                                final Insect? _insect = _isPlayer1
                                    ? state.arena.player1Insects.firstWhere(
                                        (element) =>
                                            element.position?.x ==
                                                coordinates.x &&
                                            element.position?.y ==
                                                coordinates.y)
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
                                      ? CupertinoColors.systemGrey
                                      : tileColor,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                        onLongPress: () => _insect != null
                                            ? showInsectData(_insect)
                                            : null,
                                        onDoubleTap: () => _insect != null
                                            ? showInsectData(_insect)
                                            : null,
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
                                              context.read<GamePvsPBloc>().add(
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
                                                ? Container(
                                                    constraints: constraint,
                                                    child: Image.asset(
                                                      'assets/images/${_insect.icon}.png',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              7,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : _isPossiblePositionForSelectInsect
                                                    ? Container(
                                                        constraints: constraint,
                                                        child: Image.asset(
                                                          'assets/images/${selectedInsect!.icon}.png',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7,
                                                          fit: BoxFit.cover,
                                                          color: CupertinoColors
                                                              .systemGrey4,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
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
                        shouldShow: () => state is! Player1Turn,
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
                                    onLongPress: () => showInsectData(_insect),
                                    onDoubleTap: () => showInsectData(_insect),
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
                                      child: Image.asset(
                                        'assets/images/${_insect.icon}.png',
                                        height:
                                            MediaQuery.of(context).size.height /
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
        );
      },
    );
  }
}
