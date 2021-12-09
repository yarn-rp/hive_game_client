import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DedicatedTabItem {
  const DedicatedTabItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

class DedicatedBottomTabBar extends StatefulWidget {
  const DedicatedBottomTabBar({
    Key? key,
    required this.items,
    required this.controller,
  }) : super(key: key);

  final PageController controller;
  final List<DedicatedTabItem> items;

  @override
  _DedicatedBottomTabBarState createState() => _DedicatedBottomTabBarState();
}

class _DedicatedBottomTabBarState extends State<DedicatedBottomTabBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.controller.initialPage;
    widget.controller.addListener(() {
      if (widget.controller.page?.ceil() != currentIndex) {
        setState(() {
          currentIndex = widget.controller.page!.ceil();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: (index) {
          widget.controller.jumpToPage(index);
        },
        activeColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.9),
        items: [
          ...widget.items.map(
            (e) => BottomNavigationBarItem(
              activeIcon: Icon(
                e.icon,
                size: 24,
                color: Theme.of(context).iconTheme.color,
              ),
              icon: Icon(
                e.icon,
                size: 24,
                color: CupertinoColors.inactiveGray,
              ),
              label: e.label,
            ),
          ),
        ],
      );
    } else {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'PNBold',
          fontSize: 12,
        ),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'PNBold',
          fontSize: 12,
        ),
        selectedItemColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).backgroundColor,
        selectedIconTheme: const IconThemeData(
          size: 22,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 22,
        ),
        unselectedItemColor: CupertinoColors.inactiveGray,
        items: [
          ...widget.items.map(
            (e) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 4),
                child: Icon(
                  e.icon,
                ),
              ),
              label: e.label,
            ),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          widget.controller.jumpToPage(index);
        },
      );
    }
  }
}
