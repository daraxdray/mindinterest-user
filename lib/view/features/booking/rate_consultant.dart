import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/services/database/local_storage.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/utils/alerts.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class RateConsultantScreen extends StatefulWidget {
  const RateConsultantScreen({Key? key, required this.cid, this.bookingId})
      : super(key: key);

  final int cid;
  final String? bookingId;

  @override
  _RateConsultantScreenState createState() => _RateConsultantScreenState();
}

class _RateConsultantScreenState extends State<RateConsultantScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double ratingSelected = 1;
  bool requireText = false;
  bool _fetchingData = true;
  bool busy = false;
  Consultant? consultant;
  late TmiUser user;

  void fetchData() async {
    final data = await TmiLocalStorage().getData(TmiLocalStorage.kUserDataKey);
    user = TmiUser.fromJson(json.decode(data!));
    final res = await MarketPlaceRequests().fetchConsultant(widget.cid);
    res.fold((l) {}, (r) {
      consultant = r;
      setState(() {
        _fetchingData = false;
      });
    });

    setState(() {
      _fetchingData = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          leading: InkWell(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: Icon(
              Icons.close,
              color: kBlack,
            ),
          )),
      body: _fetchingData
          ? Center(
              child: TMIButtonLoader(
                size: 18,
                color: kPrimaryColor,
              ),
            )
          : consultant != null
              ? Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'How was your session with Dr. ${consultant?.name ?? ''}?',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.getTextStyle(
                                      color: kBlack,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SmoothStarRating(
                              onRatingChanged: (double val) => setState(() {
                                    ratingSelected = val;
                                    requireText = val <= 3;
                                  }),
                              starCount: 5,
                              rating: ratingSelected,
                              size: 35.0,
                              defaultIconData: Icons.star,
                              allowHalfRating: false,
                              filledIconData: Icons.star,
                              color: kPrimaryColor,
                              borderColor: const Color(0xffC5C5C5),
                              spacing: 10),
                          const SizedBox(height: 15),
                          TMITextField(
                            hintText: "Write a review...",
                            // labelText: 'Leave  review',
                            controller: _controller,
                            maxLines: 9,
                            validator: (String? text) {
                              if (requireText == false) return null;
                              return text!.isNotEmpty
                                  ? null
                                  : 'Kindly share your experience to help us improve.';
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Could not fetch data',
                        textAlign: TextAlign.center,
                        style: AppStyles.getTextStyle(fontSize: 12),
                      ),
                      Gap(8),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _fetchingData = true;
                            });
                            fetchData();
                          },
                          child: Text('Retry'))
                    ],
                  ),
                ),
      bottomNavigationBar: consultant == null
          ? null
          : Container(
              color: kWhite,
              padding: const EdgeInsets.fromLTRB(42, 10, 42, 20),
              child: TMIButton(
                buttonText: 'Submit',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final data = <String, dynamic>{
                      "rating": ratingSelected,
                      "bid": widget.bookingId,
                      "uid": user.id,
                      "review": _controller.text
                    };
                    setState(() {
                      busy = true;
                    });
                    final res = await MarketPlaceRequests()
                        .rateSession(consultant!.id!, data: data);
                    setState(() {
                      busy = false;
                    });
                    res.fold(
                        (l) => TMIAlerts.showError(context, message: l.message),
                        (r) => GoRouter.of(context).pop());
                  }
                },
              ),
            ),
    );
  }
}
