import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/dedicated_buttons/dedicated_button.dart';

class GradientButtonWidget extends StatelessWidget {
  final Color inactiveColor;
  final bool? isActive;

  final void Function()? onPressed;
  final Widget? child;
  final List<Color>? colorsGradient;
  final double? width;
  const GradientButtonWidget({
    Key? key,
    required this.child,
    this.width,
    this.onPressed,
    this.colorsGradient,
    required this.inactiveColor,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isActive = (isActive ?? false);
    if (Theme.of(context).platform == TargetPlatform.android) {
      return Container(
        height: 40,
        width: width ?? MediaQuery.of(context).size.width / 5 * 4,
        decoration: BoxDecoration(
          gradient: _isActive
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.33, 1],
                  colors: colorsGradient ??
                      [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                      ],
                )
              : null,
          color: _isActive
              ? null
              : Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF4D4D4D)
                  : const Color(
                      0xffD2D2D2,
                    ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 40,
          width: width ?? MediaQuery.of(context).size.width / 5 * 4,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(
                  width ?? MediaQuery.of(context).size.width / 2,
                  50,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              // elevation: MaterialStateProperty.all(3),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            // style: ButtonStyle(
            //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0),
            //     ),
            //   ),
            //   minimumSize: MaterialStateProperty.all(
            //     Size(
            //       width ?? MediaQuery.of(context).size.width / 2,
            //       50,
            //     ),
            //   ),
            //   backgroundColor: isActive
            //       ? MaterialStateProperty.all(Colors.transparent)
            //       : MaterialStateProperty.all(
            //           Theme.of(context).brightness == Brightness.dark
            //               ? const Color(0xFF4D4D4D)
            //               : const Color(
            //                   0xffD2D2D2,
            //                 ),
            //         ),
            //   // elevation: MaterialStateProperty.all(3),
            //   shadowColor: MaterialStateProperty.all(Colors.transparent),
            // ),
            onPressed: onPressed,
            child: Center(
              child: child ??
                  const SizedBox(
                    height: 40,
                  ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 40,
        width: width ?? MediaQuery.of(context).size.width / 5 * 4,
        decoration: BoxDecoration(
          gradient: _isActive
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.33, 1],
                  colors: colorsGradient ??
                      [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                      ],
                )
              : null,
          color: _isActive
              ? null
              : Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF4D4D4D)
                  : const Color(
                      0xffD2D2D2,
                    ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 40,
          width: width ?? MediaQuery.of(context).size.width / 5 * 4,
          child: DedicatedButton(
            // style: ButtonStyle(
            //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0),
            //     ),
            //   ),
            //   minimumSize: MaterialStateProperty.all(
            //     Size(
            //       width ?? MediaQuery.of(context).size.width / 2,
            //       50,
            //     ),
            //   ),
            //   backgroundColor: isActive
            //       ? MaterialStateProperty.all(Colors.transparent)
            //       : MaterialStateProperty.all(
            //           Theme.of(context).brightness == Brightness.dark
            //               ? const Color(0xFF4D4D4D)
            //               : const Color(
            //                   0xffD2D2D2,
            //                 ),
            //         ),
            //   // elevation: MaterialStateProperty.all(3),
            //   shadowColor: MaterialStateProperty.all(Colors.transparent),
            // ),
            onPressed: onPressed,
            child: Center(
              child: child ??
                  const SizedBox(
                    height: 40,
                  ),
            ),
          ),
        ),
      );
    }
  }
}

class RoundedDedicatedSimpleButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? borderRadius;
  final BoxBorder? border;
  const RoundedDedicatedSimpleButton({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.width,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return Container(
        height: 40,
        width: width ?? MediaQuery.of(context).size.width / 5 * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              Size(
                width ?? MediaQuery.of(context).size.width / 2,
                50,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                color ?? Theme.of(context).colorScheme.secondary),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: child,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        height: 40,
        width: width ?? MediaQuery.of(context).size.width / 5 * 4,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          color: color ?? Theme.of(context).colorScheme.secondary,
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          pressedOpacity: 0.8,
          onPressed: onPressed,
          child: Container(
              constraints: const BoxConstraints.expand(),
              child: Center(child: child ?? Container())),
        ),
      );
    }
  }
}
