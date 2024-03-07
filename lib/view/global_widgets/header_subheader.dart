import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class HeaderSubheaderRow extends StatelessWidget {
  const HeaderSubheaderRow(
      {Key? key,
      this.title = '',
      this.subtitle = '',
      this.textAlign = TextAlign.left,
      this.titleStyle,
      this.verticalSpacing = 4,
      this.subtitleMaxLines = 3,
      this.titleMaxLines = 3,
      this.subtitleStyle})
      : super(key: key);

  final String title;
  final String subtitle;
  final TextAlign textAlign;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double verticalSpacing;
  final int? titleMaxLines;
  final int? subtitleMaxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: titleMaxLines,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle ??
                      AppStyles.getTextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: kTitleActiveColor,
                      ),
                ),
              )
            ],
          ),
        ),
        Gap(verticalSpacing),
        Row(
          children: [
            Expanded(
              child: Text(
                subtitle,
                maxLines: subtitleMaxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: textAlign,
                style: subtitleStyle ??
                    AppStyles.getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: kLabelColor,
                    ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
