import 'dart:async';

import 'package:flutter/material.dart';

const kDuration = Duration(milliseconds: 175);
const kReverseDuration = Duration(milliseconds: 100);
const kAnimCurve = Curves.easeIn;
const kReverseAnimCurve = Curves.easeIn;

class AnimatedFadeInFadeOut extends StatefulWidget {
  const AnimatedFadeInFadeOut({
    Key? key,
    required this.shouldShow,
    required this.child,
    this.onAnimationFinished,
    this.animationDuration = kDuration,
    this.reverseDuration = kReverseDuration,
    this.curve = kAnimCurve,
    this.reverseCurve = kReverseAnimCurve,
    this.shouldShrink = true,
  }) : super(key: key);

  final bool Function() shouldShow;
  final Function(bool end)? onAnimationFinished;
  final Duration animationDuration;
  final Widget child;
  final Curve curve;
  final Curve reverseCurve;
  final Duration reverseDuration;
  final bool shouldShrink;
  @override
  _AnimatedFadeInFadeOutState createState() => _AnimatedFadeInFadeOutState();
}

class _AnimatedFadeInFadeOutState extends State<AnimatedFadeInFadeOut>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late bool showit;

  late final Animation<double> _animation;
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    showit = widget.shouldShow();
    _controller = AnimationController(
      duration: widget.animationDuration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );

    _animation.addListener(() {
      if (_animation.status == AnimationStatus.dismissed && !showit) {
        widget.onAnimationFinished
            ?.call(_animation.status == AnimationStatus.dismissed && !showit);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showit = widget.shouldShow();
    _timer = Timer(widget.animationDuration,
        showit ? _controller.forward : _controller.reverse);

    if (_animation.status == AnimationStatus.completed &&
        !showit &&
        widget.shouldShrink) {
      print('Nothing in here');
      return const SizedBox.shrink();
    } else {
      return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(opacity: _animation, child: child);
        },
        child: widget.child,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
