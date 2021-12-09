import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';

class DedicatedAppBarDelegate extends SliverPersistentHeaderDelegate {
  const DedicatedAppBarDelegate({
    required this.topPadding,
    required this.height,
    this.backgroundColor,
    this.leading,
    this.title,
    this.trailing,
    this.centerTitle,
    this.bottom,
  });

  final double topPadding;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool? centerTitle;
  final double height;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DedicatedAppBar(
      height: minExtent,
      leading: leading,
      title: title,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      trailing: trailing,
      bottom: bottom,
    );
  }

  @override
  double get maxExtent =>
      height + topPadding + (bottom?.preferredSize.height ?? 0);

  @override
  double get minExtent =>
      height + topPadding + (bottom?.preferredSize.height ?? 0);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
