import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/services/notification/fcm.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/features/home/recommeded_items.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';

import 'featured_item.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NotificationService.handleInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = ref.watch(userProvider);
    final listingVM = ref.watch(consultantListingVM);

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: kBgColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(8),
                      Text(
                        'Hi, ${userVM.name?.split(' ')[0]}',
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: .2,
                          color: kBodyColor,
                        ),
                      ),
                      Text(
                        'Find your therapist',
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: .2,
                          color: kTitleActiveColor,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/notification.png'),
                  ),
                )
              ],
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TMISearchBox(
              onSubmitted: (val) {},
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'We recommend',
              textAlign: TextAlign.left,
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: .2,
                color: kTitleActiveColor,
              ),
            ),
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: FutureBuilder(
              future: listingVM.getRecommendedConsultants(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Consultant>?> snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.data == null) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Could not fetch data'),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('No recommended therapists'),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          itemCount: listingVM.recommendedConsultants!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return RecommededItemWidget(
                              consultant:
                                  listingVM.recommendedConsultants![index],
                            );
                          }),
                    );
                  }
                } else {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: TMIButtonLoader(
                        color: kPrimaryColor,
                        size: 24,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Featured',
              textAlign: TextAlign.left,
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: .2,
                color: kTitleActiveColor,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: FutureBuilder(
              future: listingVM.getFeaturedConsultants(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Consultant>?> snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.data == null) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Could not fetch data'),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('No recommended therapists'),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return FeaturedItemWidget(
                              consultant: snapshot.data![index],
                            );
                          }),
                    );
                  }
                } else {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: TMIButtonLoader(
                        color: kPrimaryColor,
                        size: 24,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
