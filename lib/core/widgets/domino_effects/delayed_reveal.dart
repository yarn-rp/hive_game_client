import 'dart:async';

import 'package:flutter/material.dart';

class DelayedReveal extends StatefulWidget {
  const DelayedReveal({
    Key? key,
    required this.child,
    required this.delay,
    this.shouldTranslate = true,
    this.curve,
  }) : super(key: key);

  final Widget child;
  final Duration delay;
  final bool shouldTranslate;
  final Curve? curve;

  @override
  _DelayedRevealState createState() => _DelayedRevealState();
}

class _DelayedRevealState extends State<DelayedReveal>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? Curves.easeInOut,
    );
    _timer = Timer(widget.delay, _controller.forward);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.shouldTranslate
              ? Transform.translate(
                  offset: Offset(0, (1 - _animation.value) * 20.0),
                  child: child,
                )
              : child,
        );
      },
      child: widget.child,
    );
  }
}
