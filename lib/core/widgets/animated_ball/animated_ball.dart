import 'dart:async';

import 'package:flutter/material.dart';

enum AnimationType { scale, fade, scafeAndFade }

class AnimatedBall extends StatefulWidget {
  const AnimatedBall(
      {Key? key,
      required this.shouldShow,
      this.color,
      this.child,
      this.size = 4,
      this.textChildInside,
      this.showCircleAround = true,
      this.onAnimationFinished,
      double? blankSpace,
      this.curve = Curves.decelerate,
      this.animationDuration = const Duration(milliseconds: 175),
      this.animationType = AnimationType.scale,
      this.circleAroundColor})
      : blanckSpace = blankSpace ?? size * 3 / 2,
        assert(child == null || textChildInside == null),
        super(key: key);

  final bool Function() shouldShow;
  final Function(bool end)? onAnimationFinished;
  final Duration animationDuration;
  final AnimationType animationType;
  final double blanckSpace;
  final Widget? child;
  final Color? circleAroundColor;
  final Color? color;
  final Curve curve;
  final bool showCircleAround;
  final double size;
  final String? textChildInside;

  @override
  _AnimatedBallState createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall>
    with SingleTickerProviderStateMixin {
  late bool removeBall;
  late bool showit;

  late Animation<double> _animation;
  late AnimationController _controller;
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
    removeBall = true;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    if (widget.onAnimationFinished != null) {
      _animation.addListener(() {
        if (_animation.status == AnimationStatus.completed) {
          print('la animacion ha terminado');
        }
        if (!showit) {
          print('no deberia mostrar la bola');
        }
        if (_animation.status == AnimationStatus.dismissed && !showit) {
          print(
              '===========================================================================termino la animacion de desvanecimineto.. dberia llamar al trigger===========================================================================');
          widget.onAnimationFinished
              ?.call(_animation.status == AnimationStatus.dismissed && !showit);

          removeBall =
              _animation.status == AnimationStatus.dismissed && !showit;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showit = widget.shouldShow();
    _timer = Timer(widget.animationDuration,
        showit ? _controller.forward : _controller.reverse);
    removeBall = removeBall && !showit;
    if (!removeBall)
      // ignore: curly_braces_in_flow_control_structures
      return AnimatedBuilder(
        animation: _animation,
        child: widget.showCircleAround
            ? CircleAvatar(
                radius: widget.blanckSpace,
                backgroundColor: widget.circleAroundColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? Color(0XFF0C1A24)
                        : Colors.white),
                child: Container(
                  alignment: Alignment.center,
                  height: widget.size * 2.15,
                  width: widget.size * 2.15 +
                      ((widget.textChildInside != null &&
                              (widget.textChildInside?.length ?? 0) > 1)
                          ? 4
                          : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.size),
                    color: widget.color ?? Theme.of(context).primaryColor,
                  ),
                  child: widget.child ??
                      (widget.textChildInside != null
                          ? Center(
                              child: Text(
                                widget.textChildInside!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: widget.size * 3 / 2,
                                    ),
                              ),
                            )
                          : null),
                ),
              )
            : Container(
                alignment: Alignment.center,
                height: widget.size * 2.15,
                width: widget.size * 2.15 +
                    ((widget.textChildInside != null &&
                            (widget.textChildInside?.length ?? 0) > 1)
                        ? 4
                        : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.size),
                  color: widget.color ?? Theme.of(context).primaryColor,
                ),
                child: widget.child ??
                    (widget.textChildInside != null
                        ? Center(
                            child: Text(
                              widget.textChildInside!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          )
                        : null),
              ),
        builder: (BuildContext context, Widget? child) {
          switch (widget.animationType) {
            case AnimationType.fade:
              return FadeTransition(
                  opacity: _animation,
                  /* offset: Offset(0.0, (1 - _animation.value) * 20.0), */
                  child: child);

            case AnimationType.scale:
              return ScaleTransition(
                  scale: _animation,
                  /* offset: Offset(0.0, (1 - _animation.value) * 20.0), */
                  child: child);

            case AnimationType.scafeAndFade:
              return FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                    scale: _animation,
                    /* offset: Offset(0.0, (1 - _animation.value) * 20.0), */
                    child: child),
              );

            default:
              return ScaleTransition(
                  scale: _animation,
                  /* offset: Offset(0.0, (1 - _animation.value) * 20.0), */
                  child: child);
          }
        },
      );
    else {
      return const SizedBox.shrink();
    }
  }
}

class IconButtonAnimated extends StatefulWidget {
  const IconButtonAnimated(
      {Key? key,
      required this.icon,
      this.top,
      this.right,
      required this.onTapCallback,
      required this.shouldShow,
      this.color,
      this.bottom,
      this.left,
      this.width,
      this.height,
      this.childInsideBall,
      this.ballSize = 4,
      this.showCircleAround = true,
      this.blankSpace,
      this.animationDuration = const Duration(milliseconds: 175),
      this.containerSize})
      : super(key: key);

  final void Function() onTapCallback;
  final bool Function() shouldShow;
  final Duration animationDuration;
  final double ballSize;
  final double? blankSpace;
  final double? bottom;
  final Widget? childInsideBall;
  final Color? color;
  final Size? containerSize;
  final double? height;
  final Widget icon;
  final double? left;
  final double? right;
  final bool showCircleAround;
  final double? top;
  final double? width;

  @override
  _IconButtonAnimatedState createState() => _IconButtonAnimatedState();
}

class _IconButtonAnimatedState extends State<IconButtonAnimated> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.containerSize?.height,
      width: widget.containerSize?.width,
      child: IconButton(
        onPressed: () {
          setState(() {});
          widget.onTapCallback();
        },
        icon: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            widget.icon,
            Positioned(
                top: widget.top,
                right: widget.right,
                bottom: widget.bottom,
                left: widget.left,
                width: widget.width,
                height: widget.height,
                child: AnimatedBall(
                  size: widget.ballSize,
                  blankSpace: widget.blankSpace,
                  animationDuration: widget.animationDuration,
                  shouldShow: widget.shouldShow,
                  color: widget.color ?? Theme.of(context).accentColor,
                  child: widget.childInsideBall,
                ))
          ],
        ),
      ),
    );
  }
}
