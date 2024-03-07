import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool dismissible = true,
}) async {
  return showModalBottomSheet<T>(
    isDismissible: dismissible,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return child;
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
}

Future<T?> showAppDialog<T>(BuildContext context,
    {required Widget child, bool dismissible = true}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    builder: (context) => Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: child,
      ),
    ),
  );
}

class BottomSheetCapsule extends StatelessWidget {
  const BottomSheetCapsule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            color: kLineColor,
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ],
    );
  }
}
