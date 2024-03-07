import 'package:flutter/material.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/wrapped_check_boxes.dart';

class BookingExpectationScreen extends StatelessWidget {
  const BookingExpectationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderSubheaderRow(
          title:
              'What are your expectations from this session?\nA therapist who...',
        ),
        Flexible(
          child: WrappedCheckItemsPicker(
            onChanged: (list) {
              print(list);
            },
            items: const [
              'Explores my past',
              'Listen',
              'Guides me to set goals',
              'Teaches new skills',
              'Other',
              'Checks in with me'
            ],
          ),
        ),
        // const Gap(32),
      ],
    );
  }
}
