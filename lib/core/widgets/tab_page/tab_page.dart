import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive_game_client/core/widgets/dedicated_app_bar/cupertino_tab_bar.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/dedicated_refresh_scaffold/dedicated_refresh_scaffold.dart';

class TabPage extends StatefulWidget {
  const TabPage({
    Key? key,
    required this.pages,
    this.tabTitles,
    this.titlePage,
    this.initialIndex = 0,
    this.tabTitlesWidgets,
    this.isScrollable = false,
    this.labelPadding,
  }) : super(key: key);

  final List<Widget> pages;
  final List<String>? tabTitles;
  final Widget? titlePage;
  final int initialIndex;
  final List<Widget>? tabTitlesWidgets;
  final bool isScrollable;
  final EdgeInsets? labelPadding;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: (widget.tabTitles ?? widget.tabTitlesWidgets)!.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DedicatedScaffold(
      appBar: DedicatedAppBar(
        forceAndroid: false,
        height: Theme.of(context).platform == TargetPlatform.iOS
            ? kMinInteractiveDimensionCupertino +
                MediaQuery.of(context).viewPadding.top
            : kToolbarHeight,
        border: Border.all(color: Colors.transparent),
        centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
        title: widget.titlePage,
        // height: kMinInteractiveDimensionCupertino +
        //     MediaQuery.of(context).viewPadding.top,
        bottom: CupertinoUpperBar(
          duration: Duration.zero,
          height: 36,
          controller: tabController,
          onTabChange: (_) {},
          labelPadding: widget.labelPadding,
          isScrollable: widget.isScrollable,
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.84),
          tabs: widget.tabTitlesWidgets ??
              [
                ...widget.tabTitles!.map(
                  (tabName) => Tab(
                    child: Text(
                      tabName,
                      style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: Theme.of(context).platform == TargetPlatform.iOS
              ? (MediaQuery.of(context).viewPadding.top > 16
                  ? MediaQuery.of(context).viewPadding.top
                  : 16)
              : 16,
        ),
        child: TabBarView(
          controller: tabController,
          children: widget.pages,
        ),
      ),
    );
  }
}
