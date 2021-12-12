import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/animated_fade_in_fade_out/animated_fade_in_fade_out.dart';
import 'package:hive_game_client/core/widgets/bottom_sheets/action_sheets/indicator_upper_bottom_sheet.dart';
import 'package:hive_game_client/core/widgets/buttons/gradient_button.dart';
import 'package:hive_game_client/core/widgets/dedicated_refresh_scaffold/dedicated_refresh_scaffold.dart';

class OnlandingPage extends StatelessWidget {
  const OnlandingPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return DedicatedScaffold(
      bottomSafe: true,
      backgroundColor: Color(0xff121212),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedFadeInFadeOut(
            shouldShow: () => true,
            animationDuration: Duration(milliseconds: 1500),
            curve: Curves.decelerate,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff121212),
                      Color(0xff6853D9).withOpacity(0.8),
                      Color(0xff6853D9),
                      Color(0xFF1DD6E2),
                    ],
                    stops: [
                      0.05,
                      0.4,
                      0.6,
                      0.9
                    ]),
              ),
            ),
          ),
          Container(
            color: Color(0xff121212).withOpacity(0.15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_transparent_light.png',
                      height: 100,
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 360),
                child: Column(
                  children: [
                    RoundedDedicatedSimpleButton(
                      onPressed: () async {
                        final _player1Controller = TextEditingController();
                        final _player2Controller = TextEditingController();
                        final _playerOneName =
                            await showModalBottomSheet<String?>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IndicatorUpperBottomSheet(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Text(
                                      'Escribe tu nombre Player1',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2),
                                      child: TextFormField(
                                        controller: _player1Controller,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RoundedDedicatedSimpleButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          _player1Controller.text,
                                        );
                                      },
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: Text(
                                        'Aceptar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        if (_playerOneName == null) {
                          return;
                        }
                        final _playerTwoName =
                            await showModalBottomSheet<String?>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IndicatorUpperBottomSheet(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Text(
                                      'Escribe tu nombre Player2',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2),
                                      child: TextFormField(
                                        controller: _player2Controller,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RoundedDedicatedSimpleButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          _player2Controller.text,
                                        );
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        'Aceptar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        if (_playerTwoName == null) {
                          return;
                        }
                        Navigator.pushNamed(context, '/arena-hive/p-vs-p',
                            arguments: {
                              'playerOne': _playerOneName.isNotEmpty
                                  ? _playerOneName
                                  : 'Player1',
                              'playerTwo': _playerTwoName.isNotEmpty
                                  ? _playerTwoName
                                  : 'Player2',
                            });
                      },
                      color: Theme.of(context).cardColor,
                      child: Text(
                        'Player vs player',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedDedicatedSimpleButton(
                      onPressed: () async {
                        final _player1Controller = TextEditingController();

                        final _playerOneName =
                            await showModalBottomSheet<String?>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IndicatorUpperBottomSheet(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Text(
                                      'Escribe tu nombre Player1',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2),
                                      child: TextFormField(
                                        controller: _player1Controller,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RoundedDedicatedSimpleButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          _player1Controller.text,
                                        );
                                      },
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: Text(
                                        'Aceptar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        if (_playerOneName == null) {
                          return;
                        }
                        Navigator.pushNamed(context, '/arena-hive/p-vs-ai',
                            arguments: {
                              'playerOne': _playerOneName.isNotEmpty
                                  ? _playerOneName
                                  : 'Player1',
                              'playerTwo': 'HiveAI',
                            });
                      },
                      color: Theme.of(context).cardColor,
                      child: Text(
                        'Player vs AI',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedDedicatedSimpleButton(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      child: Text(
                        'Readme',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline5?.color,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Yansaro Rodriguez Paez\nJavier A. Valdes Gonzalez\n IG📸: @saturdayhub',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
