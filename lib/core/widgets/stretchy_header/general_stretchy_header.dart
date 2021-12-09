import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/dedicated_buttons/dedicated_button.dart';
import 'package:hive_game_client/core/widgets/domino_effects/delayed_reveal.dart';

import 'package:hive_game_client/core/widgets/stretchy_header/stretchy_header_sliver_delegate.dart';

typedef CallbackFunction = FutureOr<void> Function();

class GeneralStretchyHeader extends StretchyHeaderDelegate {
  GeneralStretchyHeader({
    required double minExtent,
    required double maxExtent,
    double transitionScale = 1,
    AsyncCallback? onRefresh,
    this.backgroundColor,
    this.backgroundWidget,
    this.onTapTitle,
    this.title,
    this.trailing,
    this.leading,
  }) : super(
          minExtent: minExtent,
          maxExtent: maxExtent,
          transitionScale: transitionScale,
          onRefresh: onRefresh,
          showOnScreenConfiguration:
              const PersistentHeaderShowOnScreenConfiguration(),
          snapConfiguration: FloatingHeaderSnapConfiguration(
            curve: Curves.easeInOutCubic,
          ),
        );

  final Color? backgroundColor;
  final Widget? backgroundWidget;
  final Widget? title;
  final Widget? trailing;
  final Widget? leading;
  final CallbackFunction? onTapTitle;

  @override
  Widget buildGivenScales(BuildContext context, bool overlapsContent,
      double shrinkOffsetScaled, double translation) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: (Theme.of(context).brightness == Brightness.light
                    ? Color(0x4D000000)
                    : CupertinoColors.systemGrey)
                .withOpacity(1 - shrinkOffsetScaled),
            width: 0,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: backgroundWidget ?? const SizedBox.shrink(),
          ),
          IgnorePointer(
            child: Container(
              constraints: const BoxConstraints.expand(),
              color: interpolateColor(Colors.transparent, shrinkOffsetScaled,
                  finalScale: 0.75,
                  finalColor: backgroundColor ?? Theme.of(context).canvasColor
                  // finalColor: Colors.transparent,
                  ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: (1 - shrinkOffsetScaled) * 18,
                  sigmaY: (1 - shrinkOffsetScaled) * 18,
                ),
                child: Container(
                  constraints: const BoxConstraints.expand(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: minExtent,
            // color: Colors.red,
            child: DedicatedAppBar(
              forceAndroid: true,
              elevation: 0,
              height: minExtent,
              title: title != null
                  ? Visibility(
                      visible: shrinkOffsetScaled < 0.15,
                      child: DelayedReveal(
                        delay: Duration.zero,
                        shouldTranslate: false,
                        child: DedicatedIconButton(
                            onPressed: onTapTitle, icon: title!),
                      ),
                    )
                  : null,
              leading: DedicatedIconButton(
                onPressed: () {
                  // Beamer.of(context).beamBack();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: interpolateColor(
                    Colors.white, shrinkOffsetScaled,
                    finalScale: 0.5,
                    finalColor: Theme.of(context).iconTheme.color!,
                    // finalColor: Colors.transparent,
                  ),
                ),
              ),
              trailing: trailing,
              backgroundColor: shrinkOffsetScaled < 0.5
                  ? backgroundColor?.withOpacity(0.01)
                  : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
