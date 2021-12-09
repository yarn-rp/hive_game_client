import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_game_client/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
import 'package:hive_game_client/core/widgets/domino_effects/delayed_reveal.dart';

class DedicatedSearchBar extends StatefulWidget implements PreferredSizeWidget {
  const DedicatedSearchBar({
    Key? key,
    required this.height,
    required this.searchFocus,
    required this.onSubmitted,
    required this.controller,
    required this.onChanged,
    required this.onFocusChanged,
    this.bottom,
  }) : super(key: key);
  final void Function(bool show) onFocusChanged;
  final double height;
  final FocusNode searchFocus;
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final TextEditingController controller;

  final PreferredSizeWidget? bottom;

  @override
  _DedicatedSearchBarState createState() => _DedicatedSearchBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

class _DedicatedSearchBarState extends State<DedicatedSearchBar> {
  late bool showSearch;

  @override
  void initState() {
    super.initState();
    showSearch = false;

    widget.searchFocus.addListener(() {
      log('estoy en el listener del searchFocus');
      log('el focus esta en ${widget.searchFocus.hasFocus}');

      widget.onFocusChanged(widget.searchFocus.hasFocus);

      if (widget.searchFocus.hasFocus) {
        setState(() {
          showSearch = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: widget.height,
            minHeight: widget.height,
          ),
          child: Platform.isIOS
              ? DedicatedAppBar(
                  border: widget.bottom == null
                      ? Border(
                          bottom: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0x4D000000)
                                    : CupertinoColors.systemGrey.withAlpha(150),
                            width: 0,
                          ),
                        )
                      : Border.all(color: Colors.transparent),
                  leading: SizedBox.shrink(),
                  // backgroundColor: Colors.red,
                  centerTitle: true,
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width - 44,
                    height: widget.height,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -(MediaQuery.of(context).padding.top > 0
                              ? MediaQuery.of(context).padding.top
                              : 10.0),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: GestureDetector(
                              child: AnimatedContainer(
                                // color: Colors.red,
                                width: MediaQuery.of(context).size.width - 44,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastLinearToSlowEaseIn,
                                alignment: Alignment.centerLeft,
                                child: CupertinoSearchTextField(
                                  onTap: () {
                                    widget.searchFocus.requestFocus();
                                  },
                                  onChanged: widget.onChanged,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontSize: 18,
                                      ),
                                  onSubmitted: (value) {
                                    widget.searchFocus.unfocus();

                                    widget.onSubmitted(value);
                                    /*  _dispatchEvent(context, GetSearch()); */
                                  },
                                  focusNode: widget.searchFocus,
                                  controller: widget.controller,
                                  placeholder: 'Buscar contacto',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: kToolbarHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AnimatedContainer(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width - 32,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastLinearToSlowEaseIn,
                        alignment: Alignment.centerLeft,
                        child: CupertinoSearchTextField(
                          onTap: () {
                            widget.searchFocus.requestFocus();
                          },
                          onChanged: widget.onChanged,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 18,
                                  ),
                          onSubmitted: (value) {
                            widget.searchFocus.unfocus();

                            widget.onSubmitted(value);
                            /*  _dispatchEvent(context, GetSearch()); */
                          },
                          focusNode: widget.searchFocus,
                          controller: widget.controller,
                          placeholder: 'Buscar contacto',
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        if (widget.bottom != null) widget.bottom!
      ],
    );
  }
}
