part of 'action_sheets.dart';

class ModalActionSheetBody extends StatelessWidget {
  const ModalActionSheetBody({
    Key? key,
    required this.children,
    this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.width / 7,
            child: children[index],
          );
        },
      ),
    );
  }
}
