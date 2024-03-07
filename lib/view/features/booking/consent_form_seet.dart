import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/book_a_slot.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class ConsentFormSheet extends StatefulHookConsumerWidget {
  const ConsentFormSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConsentFormSheetState();
}

class _ConsentFormSheetState extends ConsumerState<ConsentFormSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .8,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: TMIButton(
                    buttonText: 'Reject',
                    buttonColor: kWhite,
                    borderColor: kPrimaryColor,
                    textColor: kPrimaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
                  Gap(24),
                  Expanded(
                      child: TMIButton(
                    buttonText: 'Accept',
                    onPressed: () {
                      Navigator.of(context).pop();
                      showAppBottomSheet<void>(context,
                          dismissible: false, child: const BookASlotSheet());
                    },
                  ))
                ],
              ),
              Gap(24)
            ],
          ),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Consent form',
                  style: AppStyles.getTextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: kBlack),
                ),
              ),
              Divider(),
              Gap(12),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse('https://docs.google.com/document/d/1OLsywNFsqE1XHBxdU19Ta_XSNtZGtsmPA7eyRNvzcR4/edit'), ),
                  // javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
