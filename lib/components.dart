import 'package:flutter/widgets.dart';
import 'package:nes_ui/nes_ui.dart';

const square8 = SizedBox.square(dimension: 8);
Future<T?> showGameMessage<T>({
  required BuildContext context,
  List<InlineSpan> message = const [],
  Widget? child,
}) {
  return NesDialog.show<T>(
    context: context,
    builder: (context) {
      return Column(
        children: [
          Text.rich(TextSpan(children: message)),
          if (child != null) ...[square8, child],
        ],
      );
    },
  );
}
