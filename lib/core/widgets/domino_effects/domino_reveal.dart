import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/domino_effects/delayed_reveal.dart';

// This function increments and returns a Duration
// The delay is reset when no new animations have been added for a short moment
//  (you can change the conditions of this to match your requirements)
Timer? _dominoReset;
Duration _dominoDelay = Duration.zero;
Duration _getDelay(Duration d) {
  if (_dominoReset == null || !_dominoReset!.isActive) {
    _dominoReset = Timer(d, () {
      _dominoDelay = Duration.zero;
    });
  }
  return _dominoDelay += d;
}

class DominoReveal extends StatelessWidget {
  const DominoReveal({
    Key? key,
    required this.child,
    this.shouldTranslate = true,
    this.delay = const Duration(milliseconds: 100),
  }) : super(key: key);

  final Widget child;
  final bool shouldTranslate;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      shouldTranslate: shouldTranslate,
      delay: _getDelay(delay),
      child: child,
    );
  }
}
