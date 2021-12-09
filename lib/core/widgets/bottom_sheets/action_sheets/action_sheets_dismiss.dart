part of 'action_sheets.dart';

class ModalActionSheetDismiss extends StatelessWidget {
  const ModalActionSheetDismiss({
    Key? key,
    this.handleTap,
    this.child,
  }) : super(key: key);

  final void Function()? handleTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap ??
          () {
            log('cancel');
            Navigator.of(context).pop('cancel');
          },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0XFF394854),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          child: child ??
              const Center(
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    letterSpacing: 0.1,
                    fontFamily: 'SFPro',
                    color: Color(0XFF3563dd),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
