import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/chat_item_model.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatItem extends HookConsumerWidget {
  ChatItem({Key? key, required this.chatItem, required this.index})
      : super(key: key);

  final ChatItemModel chatItem;
  final int index;
  bool canRoute = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (canRoute) {
          GoRouter.of(context).push(RoutePaths.conversationScreen +
              "?cid=${chatItem.cid}&bid=${chatItem.conversationId}");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(),
        child: FutureBuilder(
          future: ref.read(chatVM).getConsultant(chatItem.cid!),
          builder: ((context, AsyncSnapshot<Consultant> snapshot) {
            if (snapshot.hasError ||
                snapshot.data == null &&
                    snapshot.connectionState == ConnectionState.done) {
              SizedBox();
            }
            if (snapshot.hasData) {
              final consultant = snapshot.data;
              canRoute = true;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAvatar(
                    ringColor: kSecondaryColor,
                    height: 42,
                    width: 42,
                    url: consultant!.profileImg!,
                  ),
                  const Gap(12),
                  Expanded(
                    child: HeaderSubheaderRow(
                      title: 'Dr. ${consultant.name!}',
                      titleMaxLines: 1,
                      subtitleMaxLines: 2,
                      titleStyle: AppStyles.getTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: kTitleActiveColor,
                      ),
                      subtitle: chatItem.lastMesage!.text!,
                      subtitleStyle: AppStyles.getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: kLabelColor,
                      ),
                    ),
                  ),
                  Text(
                    timeago.format(chatItem.lastMesage!.date!),
                    style: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              );
            } else {
              return AnimatedShimmer(
                height: 60,
                width: size.width - 20,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                delayInMilliSeconds: Duration(milliseconds: index * 500),
              );
            }
          }),
        ),
      ),
    );
  }
}
