import 'dart:io';

import 'package:flutter/material.dart';

class DedicatedScaffold extends StatelessWidget {
  const DedicatedScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomAppBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.bottomSafe = false,
    this.tapToExitKeyboard = true,
  }) : super(key: key);

  final Widget? bottomAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final bool bottomSafe;
  final bool tapToExitKeyboard;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SafeArea(
        top: false,
        right: false,
        left: false,
        bottom: bottomSafe,
        child: GestureDetector(
          onTap: tapToExitKeyboard
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          child: Scaffold(
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButton: floatingActionButton,
            backgroundColor:
                backgroundColor ?? Theme.of(context).backgroundColor,
            extendBodyBehindAppBar: true,
            extendBody: true,
            bottomNavigationBar: bottomAppBar,
            appBar: appBar,
            body: body,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: tapToExitKeyboard
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          : null,
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        bottom: bottomSafe,
        child: Scaffold(
          bottomNavigationBar: bottomAppBar,
          appBar: appBar,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          extendBody: false,
          backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
          body: body,
        ),
      ),
    );
  }
}
