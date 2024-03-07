import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class ChipText extends StatelessWidget {
  const ChipText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: kInputBGColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: AppStyles.getTextStyle(
            fontSize: 10, fontWeight: FontWeight.normal, color: kLabelColor),
      ),
    );
  }
}
