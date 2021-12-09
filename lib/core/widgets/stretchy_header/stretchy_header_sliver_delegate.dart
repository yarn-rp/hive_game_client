import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/basic_types.dart';

abstract class StretchyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StretchyHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    this.transitionScale = 1,
    this.showOnScreenConfiguration =
        const PersistentHeaderShowOnScreenConfiguration(),
    this.snapConfiguration,
    this.onRefresh,
  });

  final AsyncCallback? onRefresh;

  /// Value from 0-1 where establishes how fast transition will execute
  final double transitionScale;

  @override
  final double minExtent, maxExtent;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        onStretchTrigger: onRefresh,
      );

  /// Scales shrinkOffset to values from 0-1. If 0, means that sliver height
  /// is maxExtent. If 1, means that sliver reached it's minExtent.
  double calculateOffSetOneToZeroScale(double shrinkOffset) =>
      1.0 - shrinkOffset / maxExtent;

  /// Calculates a [double] translation value of elements in sliver. Is used for
  /// animations with the same translation animation.
  double calculateTranslation(double offsetScaled) =>
      maxExtent / (transitionScale * 3 * 2.25) * (1 - offsetScaled);

  /// Middleware for optimizing interpolation when extremes are reached.
  /// If sliver position is at the extremes, won't interpolate values, instead
  /// will return extremes values.
  num interpolateScaled(
    double offsetScaled, {
    required num initialValue,
    required num finalValue,
    num initialScale = 1.0,
    num finalScale = 0.0,
    Curve curve = Curves.easeInOutCubic,
  }) {
    assert(initialScale <= 1.0 && initialScale >= 0);
    assert(finalScale <= 1.0 && finalScale >= 0);

    if (offsetScaled < initialScale) {
      if (offsetScaled > finalScale) {
        return _interpolate(
          offsetScaled,
          initialScale,
          finalScale,
          initialValue,
          finalValue,
          curve: curve,
        );
      } else {
        return finalValue;
      }
    }
    return initialValue;
  }

  Color interpolateColor(
    Color color,
    double offsetScaled, {
    Color finalColor = Colors.transparent,
    double initialScale = 1.0,
    double finalScale = 0.0,
    Curve curve = Curves.fastLinearToSlowEaseIn,
  }) {
    final alpha = color.alpha;
    final red = color.red;
    final green = color.green;
    final blue = color.blue;

    return Color.fromARGB(
      interpolateScaled(
        offsetScaled,
        initialValue: alpha,
        finalValue: finalColor.alpha,
      ).toInt(),
      interpolateScaled(
        offsetScaled,
        initialValue: red,
        finalValue: finalColor.red,
      ).toInt(),
      interpolateScaled(
        offsetScaled,
        initialValue: green,
        finalValue: finalColor.green,
      ).toInt(),
      interpolateScaled(
        offsetScaled,
        initialValue: blue,
        finalValue: finalColor.blue,
      ).toInt(),
    );
  }

  /// Interpolates value from [fromValue] to [toValue] given a scale and a
  /// [Curve] curve .
  double _interpolate(
    num offsetScaled,
    num fromScaled,
    num toScaled,
    num fromValue,
    num toValue, {
    required Curve curve,
  }) {
    // Refers to the slope in scale values
    final mScaled = toScaled - fromScaled;
    // Refers to the slope in scale values
    final mValue = toValue - fromValue;

    final proportionDouble = (offsetScaled - fromScaled) / mScaled;
    // final proportion = curve.transform(proportionDouble);
    return mValue * proportionDouble + fromValue;
  }

  Widget buildGivenScales(
    BuildContext context,
    bool overlapsContent,
    double shrinkOffsetScaled,
    double translation,
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final offsetScaled = calculateOffSetOneToZeroScale(shrinkOffset);

    final translation = calculateTranslation(offsetScaled);

    return buildGivenScales(
      context,
      overlapsContent,
      offsetScaled,
      translation,
    );
  }
}
