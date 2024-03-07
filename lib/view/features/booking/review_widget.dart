import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/rating_data.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/rating_box.dart';

class ReviewWidget extends HookConsumerWidget {
  const ReviewWidget({Key? key, required this.review, required this.index})
      : super(key: key);

  final ConsultantsRatingsReviews review;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
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
      child: FutureBuilder(
        future: ref.read(bookingVM).getUser(review.uid!),
        builder: ((context, AsyncSnapshot<TmiUser> snapshot) {
          if (snapshot.hasError ||
              snapshot.data == null &&
                  snapshot.connectionState == ConnectionState.done) {
            SizedBox();
          }
          if (snapshot.hasData) {
            final user = snapshot.data;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  url: '',
                ),
                Gap(24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user?.name ?? "",
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: kBodyColor,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        review.review ?? "",
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: kTitleActiveColor,
                        ),
                      )
                    ],
                  ),
                ),
                RatingWidget(rating: review.rating?.toDouble() ?? 0)
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
    );
  }
}
