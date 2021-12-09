import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/indicators/tab_indicator.dart';

class DedicatedTabBar extends StatefulWidget implements PreferredSizeWidget {
  const DedicatedTabBar({
    Key? key,
    required this.height,
    required this.controller,
    required this.onTabChange,
    this.bottom,
    required this.tabs,
  }) : super(key: key);
  final void Function(int index) onTabChange;
  final double height;

  final TabController controller;
  final List<Widget> tabs;
  final PreferredSizeWidget? bottom;

  @override
  _DedicatedTabBarState createState() => _DedicatedTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _DedicatedTabBarState extends State<DedicatedTabBar> {
  late bool showSearch;

  @override
  void initState() {
    super.initState();
    showSearch = false;

    widget.controller.addListener(() {
      log('estoy en el listener del searchFocus');
      log('el focus esta en ${widget.controller.index}');

      widget.onTabChange(widget.controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.height,
        minHeight: widget.height,
      ),
      child: CupertinoNavigationBar(
        // padding: EdgeInsetsDirectional.only(bottom: 8.0),
        automaticallyImplyLeading: false,
        border: Border.all(color: Colors.transparent),
        backgroundColor: Colors.red,
        middle: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.height,
            minHeight: widget.height,
          ),
          child: Container(
            color: Colors.blue,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TabBar(
                  controller: widget.controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: CustomUnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  unselectedLabelColor: CupertinoColors.systemGrey,
                  labelColor: Theme.of(context).textTheme.subtitle1?.color,
                  tabs: widget.tabs,
                )),
          ),
        ),
        transitionBetweenRoutes: false,
      ),
    );
  }
}
