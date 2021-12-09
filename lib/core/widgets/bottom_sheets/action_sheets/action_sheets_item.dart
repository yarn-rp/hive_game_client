part of 'action_sheets.dart';

class ModalActionSheetItem extends StatelessWidget {
  const ModalActionSheetItem({
    Key? key,
    this.child,
    this.text,
    this.onTap,
    required this.iconData,
  })  : assert(((child != null && onTap != null) && text == null) ||
            (text != null && (child == null && onTap == null))),
        super(key: key);

  final void Function()? onTap;
  final Widget? child;
  final IconData iconData;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap ??
          () {
            print(text);
            Navigator.of(context).pop(text);
          },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).iconTheme.color,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: child ??
                  Text(
                    text!,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 18),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
