import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/rating_box.dart';

class FeaturedItemWidget extends StatelessWidget {
  const FeaturedItemWidget({Key? key, required this.consultant})
      : super(key: key);
  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        context.push(RoutePaths.therapistDetail, extra: consultant);
      },
      child: Container(
        // height: 200,
        width: size.width,
        margin: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        padding: const EdgeInsets.all(18),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserAvatar(url: consultant.profileImg ?? ''),
                // Gap(8),
                // RatingWidget(rating: 4.8),
              ],
            ),
            const Gap(18),
            Flexible(
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
                    consultant.specialty!,
                    style: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: kLabelColor,
                    ),
                  ),
                  const Gap(8),
                  //TODO: fix rating
                  RatingWidget(rating: consultant.rating!),
                  // Flexible(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible(
                  //         child: Wrap(
                  //           runSpacing: 4,
                  //           spacing: 4,
                  //           children: [
                  //             ...[
                  //               'Job & boogyness',
                  //               'Job & boogyness',
                  //               'Job & boogyness',
                  //               'Job',
                  //             ].map((e) => ChipText(text: e)).toList(),
                  //             const ChipText(text: '+4')
                  //           ],
                  //         ),
                  //       ),
                  //       const Gap(8),
                  //       Text(
                  //         CurrencyFormatter.format(
                  //           20000,
                  //           currencyPrefix: true,
                  //         ),
                  //         textAlign: TextAlign.end,
                  //         style: AppStyles.getTextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 14,
                  //             color: kTitleActiveColor),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
