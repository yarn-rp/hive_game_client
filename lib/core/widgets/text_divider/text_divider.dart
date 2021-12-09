import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    Key? key,
    required this.text,
    this.icon,
    this.color = CupertinoColors.systemGrey,
    this.fontSize = 16,
    this.subtitle,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final Color color;
  final double fontSize;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48 + (subtitle != null ? 16 : 0),
      constraints: BoxConstraints(
        minHeight: 48 + (subtitle != null ? 16 : 0),
      ),
      alignment: Alignment.bottomLeft,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: fontSize,
                    color: color,
                  ),
                  const SizedBox(
                    width: 4,
                  )
                ],
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        // fontWeight: FontWeight.bold,
                        // letterSpacing: 0.5,
                        fontSize: fontSize,
                        color: color,
                      ),
                ),
              ],
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      // fontWeight: FontWeight.bold,
                      // letterSpacing: 0.5,
                      fontSize: 14,
                      color: color,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
