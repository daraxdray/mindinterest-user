import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key, required this.rating}) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: _getColor(rating)),
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: Colors.white,
            size: 18,
          ),
          const Gap(4),
          Text(
            rating.toString(),
            style: AppStyles.getTextStyle(
              color: kWhite,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(double rating) {
    if (rating >= 4.5) {
      return Colors.green;
    } else if (rating >= 3.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
