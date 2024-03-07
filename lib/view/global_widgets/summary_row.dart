import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class SummaryRowWidget extends StatelessWidget {
  const SummaryRowWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: AppStyles.getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: kLabelColor),
          ),
          const Gap(8),
          Text(
            data,
            textAlign: TextAlign.left,
            style: AppStyles.getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTitleActiveColor),
          )
        ],
      ),
    );
  }
}
