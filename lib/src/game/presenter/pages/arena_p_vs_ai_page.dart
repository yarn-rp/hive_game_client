import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/core/widgets/animated_fade_in_fade_out/animated_fade_in_fade_out.dart';

import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/dialogs/dialogs.dart';

import 'package:hive_game_client/src/game/models/insect/insect.dart';
import 'package:hive_game_client/src/game/models/models.dart';
import 'package:hive_game_client/src/game/presenter/widgets/show_insect_data.dart';
import 'package:hive_game_client/src/game/state_management/player_vs_ai/game_p_vs_ai_bloc.dart';

class ArenaPvsAiPage extends StatelessWidget {
  final String playerOne;

  static const routeName = '/arena-hive/p-vs-ai';

  const ArenaPvsAiPage({
    Key? key,
    required this.playerOne,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GamePVsAiBloc(
        playerOne,
      ),
      child: ArenaPvsAiView(
        playerOne: playerOne,
      ),
    );
  }
}

class ArenaPvsAiView extends StatefulWidget {
  final String playerOne;

  const ArenaPvsAiView({
    Key? key,
    required this.playerOne,
  }) : super(key: key);

  @override
  State<ArenaPvsAiView> createState() => ArenaPvsAiViewState();
}

class ArenaPvsAiViewState extends State<ArenaPvsAiView> {
  late TransformationController _transformationController;
  Insect? selectedInsect;
  bool loaded = false;
  @override
  void initState() {
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
    return BlocConsumer<GamePVsAiBloc, GamePVsAiState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: DedicatedAppBar(
            centerTitle: true,
            title: Text('${widget.playerOne} vs HIVE-AI'),
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
                        shouldShow: () => state is! AiTurn,
                        child: Builder(builder: (context) {
                          final _child = Container(
                            color: Theme.of(context).backgroundColor,
                            child: Center(
                              child: state is Loading
                                  ? SizedBox()
                                  : Text(
                                      'Wait for your oponents move',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                            ),
                          );
                          if (state is AiTurn) {
                            return _child;
                          } else {
                            return IgnorePointer(
                              child: _child,
                            );
                          }
                        }),
                      ),
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is AiTurn,
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
                            itemCount: state.aiHand.length,
                            itemBuilder: (context, index) {
                              final _insect = state.aiHand[index];
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
                                final _isPlayer1 = state.arena.player1.insects
                                    .any((element) =>
                                        element.position?.x == coordinates.x &&
                                        element.position?.y == coordinates.y);
                                final _isPlayer2 = state.arena.player2.insects
                                    .any((element) =>
                                        element.position?.x == coordinates.x &&
                                        element.position?.y == coordinates.y);
                                final Insect? _insect = _isPlayer1
                                    ? state.arena.player1.insects.firstWhere(
                                        (element) =>
                                            element.position?.x ==
                                                coordinates.x &&
                                            element.position?.y ==
                                                coordinates.y)
                                    : _isPlayer2
                                        ? state.arena.player2.insects
                                            .firstWhere((element) =>
                                                element.position?.x ==
                                                    coordinates.x &&
                                                element.position?.y ==
                                                    coordinates.y)
                                        : null;
                                final _isPossiblePositionForSelectInsect =
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
                                            ? showInsectData(context, _insect)
                                            : null,
                                        onDoubleTap: () => _insect != null
                                            ? showInsectData(context, _insect)
                                            : null,
                                        onTap: () {
                                          if (selectedInsect != null) {
                                            if (!(true)) {
                                              showErrorDialog(
                                                  context: context,
                                                  title: 'Movimiento invalido',
                                                  description:
                                                      'Este insecto no se puede mover a esta posicion');
                                            } else {
                                              context.read<GamePVsAiBloc>().add(
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
                                                      'assets/images/${_insect.type}.png',
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
                                                          'assets/images/${selectedInsect!.type}.png',
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
                        shouldShow: () => state is! MyTurn,
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
                          if (state is MyTurn) {
                            return _child;
                          } else {
                            return IgnorePointer(
                              child: _child,
                            );
                          }
                        }),
                      ),
                      AnimatedFadeInFadeOut(
                        shouldShow: () => state is MyTurn,
                        shouldShrink: false,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          itemCount: state.myHand.length,
                          itemBuilder: (context, index) {
                            final _insect = state.myHand[index];
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
                                        'assets/images/${_insect.type}.png',
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
