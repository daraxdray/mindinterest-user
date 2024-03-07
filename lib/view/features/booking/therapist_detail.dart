import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/data_models/rating_data.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/currency_fomatter.dart';
import 'package:mindintrest_user/view/features/booking/consent_form_seet.dart';
import 'package:mindintrest_user/view/features/booking/review_widget.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/rating_box.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TherapistDetailScreen extends StatefulHookConsumerWidget {
  const TherapistDetailScreen({Key? key, required this.consultant})
      : super(key: key);

  final Consultant consultant;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TherapistDetailScreenState();
}

class _TherapistDetailScreenState extends ConsumerState<TherapistDetailScreen> {
  late Consultant consultant;

  bool _isLoading = true;
  List<ConsultantsRatingsReviews?> _reviews = [];

  void fetchRating(int id) async {
    var res = await MarketPlaceRequests().getReviews(consultantId: id);
    setState(() {
      _reviews = res.fold((l) => [], (r) => r);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    consultant = widget.consultant;
    fetchRating(consultant.id!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You pay',
                      style: AppStyles.getTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .2,
                        color: kLabelColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      CurrencyFormatter.format(
                          consultant.hourlyRate!.toDouble()),
                      style: AppStyles.getTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .5,
                        color: kTitleActiveColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Per session',
                      style: AppStyles.getTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .2,
                        color: kLabelColor,
                      ),
                    ),
                  ],
                ),
                TMIButton(
                  buttonText: 'Book Session',
                  onPressed: () {
                    ref.read(bookingVM).clearBookinfData();
                    ref.read(bookingVM).setViewingConsultant(consultant);
                    showAppBottomSheet<void>(context,
                        dismissible: false, child: const ConsentFormSheet());

                    // showAppBottomSheet<void>(context,
                    //     child: const BookASlotSheet());
                  },
                )
              ],
            ),
            const Gap(12),
          ],
        ),
      ),
      body: SlidingUpPanel(
        // color: Colors.red,
        parallaxEnabled: true,
        minHeight: size.height * .7,
        maxHeight: size.height * .9,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        panel: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(8),
              const BottomSheetCapsule(),
              const Gap(16),
              Row(
                children: [
                  Flexible(
                    child: HeaderSubheaderRow(
                      title: 'Dr. ${consultant.name}',
                      subtitle: consultant.specialty!,
                      titleStyle: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: kTitleActiveColor),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      CurrencyFormatter.format(
                          consultant.hourlyRate!.toDouble(),
                          currencyPrefix: true),
                      style: AppStyles.getTextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      consultant.approvalStatus == 1 ? 'Verified' : 'Pending',
                      style: AppStyles.getTextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                  const Gap(8),
                  RatingWidget(rating: consultant.rating!)
                ],
              ),
              const Gap(24),
              Flexible(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    wrapItem(
                      asset: 'assets/images/briefcase.png',
                      title: '${consultant.experience}',
                    ),
                    wrapItem(
                      asset: 'assets/images/language.png',
                      title: consultant.languages != null
                          ? consultant.languages!.lang!.join(', ')
                          : 'English',
                    ),
                    // wrapItem(
                    //   asset: 'assets/images/people.png',
                    //   title: '2 Sessions', //TODO: fix this
                    // )
                  ],
                ),
              ),
              const Gap(24),
              Text(
                'About',
                textAlign: TextAlign.left,
                style: AppStyles.getTextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: .2,
                  color: kTitleActiveColor,
                ),
              ),
              const Gap(12),
              Flexible(
                flex: 3,
                child: SingleChildScrollView(
                  child: ReadMoreText(
                    consultant.bio!,
                    trimLength: 200,
                    style: AppStyles.getTextStyle(
                      color: kTitleActiveColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                    colorClickableText: kPrimaryDark,
                    // trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    lessStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryDark,
                    ),
                    moreStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryDark,
                    ),
                  ),
                ),
              ),
              const Gap(24),
              Text(
                'Reviews',
                textAlign: TextAlign.left,
                style: AppStyles.getTextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: .2,
                  color: kTitleActiveColor,
                ),
              ),
              const Gap(12),
              SizedBox(
                height: size.height / 2.5,
                child: _isLoading
                    ? Center(
                        child: TMIButtonLoader(
                          size: 18,
                          color: kPrimaryColor,
                        ),
                      )
                    : _reviews.isEmpty
                        ? Center(
                            child: Text('No reviews yet.'),
                          )
                        : ListView.builder(itemBuilder: ((context, index) {
                            final item = _reviews[index];
                            return ReviewWidget(
                              index: index,
                              review: item!,
                            );
                          })),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height * .6,
          child: Stack(
            children: [
              AppNetworkImage(
                url: consultant.profileImg,
              ),
              Positioned(
                top: 42,
                left: 18,
                child: TMIBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wrapItem({String title = '', String asset = ''}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(asset),
        ),
        const Gap(8),
        Text(
          title,
          style: AppStyles.getTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: kBodyColor,
          ),
        )
      ],
    );
  }
}
