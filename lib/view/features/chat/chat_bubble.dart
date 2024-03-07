import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/chat_model.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMine;
  ChatBubble(this.message, {this.isMine = false});
  @override
  Widget build(BuildContext context) {
    return chatWidget(context, isMine);
  }

  Widget chatWidget(BuildContext context, bool isMine) {
    List<Widget> children = [
      Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.50, minWidth: 150),
        decoration: BoxDecoration(
            color: isMine ? kBodyColor : kPrimaryColor,
            borderRadius: isMine
                ? BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))
                : BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text!,
              style: AppStyles.getTextStyle(
                color: kWhite,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Gap(3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormatter.formatBubbleTime(message.date),
                  style: AppStyles.getTextStyle(
                    color: kBgColor,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ],
        ),
      )
    ];

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children),
    );
  }
}
