import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_search_bar.dart';

class DedicatedSearchBarDelegate extends SliverPersistentHeaderDelegate {
  const DedicatedSearchBarDelegate({
    Key? key,
    required this.height,
    required this.topPadding,
    required this.searchFocus,
    required this.onSubmitted,
    required this.controller,
    required this.onChanged,
    required this.onFocusChanged,
  });
  final void Function(bool show) onFocusChanged;
  final double height;
  final double topPadding;
  final FocusNode searchFocus;
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final TextEditingController controller;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DedicatedSearchBar(
      onSubmitted: onSubmitted,
      height: minExtent,
      searchFocus: searchFocus,
      onChanged: onChanged,
      onFocusChanged: onFocusChanged,
      controller: controller,
    );
  }

  @override
  double get maxExtent => height + topPadding;

  @override
  double get minExtent => height + topPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
