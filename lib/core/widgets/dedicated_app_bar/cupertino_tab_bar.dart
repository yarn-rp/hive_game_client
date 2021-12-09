import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/domino_effects/delayed_reveal.dart';
import 'package:hive_game_client/core/widgets/indicators/tab_indicator.dart';

import 'cupertino_nav_bar.dart';

class CupertinoUpperBar extends StatefulWidget implements PreferredSizeWidget {
  const CupertinoUpperBar({
    Key? key,
    this.backgroundColor,
    required this.onTabChange,
    required this.height,
    required this.controller,
    required this.tabs,
    this.bottom,
    this.border,
    this.duration,
    this.indicatorSize,
    this.isScrollable,
    this.labelPadding,
  }) : super(key: key);

  final void Function(int index) onTabChange;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final TabController controller;
  final double height;
  final List<Widget> tabs;
  final Border? border;
  final Duration? duration;
  final TabBarIndicatorSize? indicatorSize;
  final bool? isScrollable;
  final EdgeInsets? labelPadding;
  @override
  _CupertinoUpperBarState createState() => _CupertinoUpperBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

class _CupertinoUpperBarState extends State<CupertinoUpperBar> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = CupertinoDynamicColor.maybeResolve(
            widget.backgroundColor ??
                Theme.of(context).backgroundColor.withOpacity(0.90),
            context) ??
        CupertinoTheme.of(context).barBackgroundColor;

    final navBar = wrapWithBackground(
      updateSystemUiOverlay: false,
      border: widget.border ??
          Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0x4D000000)
                  : CupertinoColors.systemGrey,
              width: 0, // One physical pixel.
            ),
          ),
      backgroundColor: backgroundColor,
      brightness: Brightness.dark,
      child: SizedBox(
        height: widget.height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: widget.controller,
            physics: const AlwaysScrollableScrollPhysics(),
            // labelPadding: const EdgeInsets.symmetric(horizontal: 4),
            indicatorSize: widget.indicatorSize ?? TabBarIndicatorSize.tab,
            isScrollable: widget.isScrollable ?? false,

            labelPadding: widget.labelPadding,
            indicator: CustomUnderlineTabIndicator(
              insets: const EdgeInsets.symmetric(horizontal: 16),
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            unselectedLabelColor: CupertinoColors.systemGrey,
            labelColor: Theme.of(context).textTheme.subtitle1?.color,
            tabs: widget.tabs,
          ),
        ),
      ),
    );

    if (widget.duration != null) {
      return DelayedReveal(
        shouldTranslate: false,
        delay: widget.duration!,
        child: navBar,
      );
    }
    return navBar;
  }
}
