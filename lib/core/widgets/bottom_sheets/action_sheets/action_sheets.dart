import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive_game_client/core/widgets/bottom_sheets/action_sheets/indicator_upper_bottom_sheet.dart';
part 'action_sheets_body.dart';
part 'action_sheets_dismiss.dart';
part 'action_sheets_item.dart';

class ActionItem {
  ActionItem(
    this.text,
    this.iconData, {
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });

  final IconData iconData;
  final String text;
  final bool isDefaultAction;
  final bool isDestructiveAction;
}

Future<String?> showActionsSheetString(
  BuildContext context,
  List<ActionItem> actions, {
  Widget? header,
  Widget? iosTitle,
}) {
  if (Platform.isIOS) {
    return showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Theme.of(context).brightness,
        ),
        child: CupertinoActionSheet(
            title: iosTitle,
            /* message: const Text(
              'Your options are ',
              style: TextStyle(fontFamily: 'ProximaNova'),
            ), */
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop('Cancelar');
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  fontFamily: 'PNRegular',
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            actions: actions.map((e) {
              return CupertinoActionSheetAction(
                isDefaultAction: e.isDefaultAction,
                isDestructiveAction: e.isDestructiveAction,
                child: Text(
                  e.text,
                  style: TextStyle(
                    fontFamily: 'PNRegular',
                    color: e.isDestructiveAction
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(e.text);
                },
              );
            }).toList()),
      ),
    );
  }
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      )),
      elevation: 10,
      barrierColor: Colors.black.withOpacity(0.90),
      backgroundColor: Theme.of(context).backgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IndicatorUpperBottomSheet(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              color: Theme.of(context).dividerColor,
            ),
            header ?? Container(),
            const SizedBox(
              height: 12,
            ),
            Divider(
              height: 0,
              color: Theme.of(context).dividerColor,
            ),
            ModalActionSheetBody(
              children: actions
                  .map((element) => ModalActionSheetItem(
                        text: element.text,
                        iconData: element.iconData,
                      ))
                  .toList(),
            ),
          ],
        );
      });
}

Future<String?> showActionsSheetGeneral(
    BuildContext context, List<Widget> actions) {
  return showModalBottomSheet<String?>(
      elevation: 10,
      barrierColor: Colors.black.withOpacity(0.85),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.up,
              children: [
                ModalActionSheetBody(children: actions),
              ],
            ),
          ),
        );
      });
}

Future<String?> showDiventFollowersModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<String?>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 10,
      barrierColor: Colors.black.withOpacity(0.90),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      });
}
