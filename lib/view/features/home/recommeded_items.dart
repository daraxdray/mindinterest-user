import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/rating_box.dart';

class RecommededItemWidget extends StatelessWidget {
  const RecommededItemWidget({Key? key, required this.consultant})
      : super(key: key);

  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RoutePaths.therapistDetail, extra: consultant);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 24, 10),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(minWidth: 250, maxWidth: 250),
        // height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.07),
              blurRadius: 18,
              spreadRadius: 7,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                UserAvatar(
                  url: consultant.profileImg!,
                ),
              ],
            ),
            const Gap(18),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${consultant.name}',
                    style: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: kTitleActiveColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '${consultant.specialty}',
                    style: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: kLabelColor,
                    ),
                  ),
                  const Gap(8),
                  RatingWidget(rating: consultant.rating!), //TODO: fix
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
