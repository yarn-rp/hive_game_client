import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    Key? key,
    required this.tag,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.subtitle,
    this.padding = const EdgeInsets.only(left: 20, right: 20, bottom: 8),
    this.tagSize = 24,
    this.tagColor,
    this.actions,
    this.centerTitle = false,
  }) : super(key: key);

  final Widget? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final EdgeInsetsGeometry padding;
  final String? subtitle;
  final String tag;
  final Color? tagColor;
  final double tagSize;
  final Color textColor;

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Container(
        color: widget.backgroundColor,
        alignment: Alignment.center,
        child: Padding(
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: widget.centerTitle
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tag,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: widget.tagSize,
                          color: widget.tagColor,
                        ),
                  ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: widget.textColor,
                          ),
                    ),
                ],
              ),
              if (widget.actions != null) widget.actions!
            ],
          ),
        ),
      ),
    );
  }
}
