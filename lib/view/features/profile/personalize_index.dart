import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/state/auth/auth_vm.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/features/onboarding/are_you_a_parent.dart.dart';
import 'package:mindintrest_user/view/features/onboarding/collect_age.dart';
import 'package:mindintrest_user/view/features/onboarding/how_often.dart';
import 'package:mindintrest_user/view/features/onboarding/relationship_status.dart';
import 'package:mindintrest_user/view/features/onboarding/relationship_status_duration.dart';
import 'package:mindintrest_user/view/global_widgets/async_aware.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class PersonalizeIndexScreen extends StatefulHookConsumerWidget {
  const PersonalizeIndexScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalizeIndexScreenState();
}

class _PersonalizeIndexScreenState
    extends ConsumerState<PersonalizeIndexScreen> {
  late PageController _pageController;
  late int _currentIndex;
  late List<Widget> _screens;
  late bool _buttonEnabled;

  @override
  void initState() {
    _screens = const [
      SelectAgeScreen(),
      NeedToTalkScreen(),
      RelationshipStatusScreen(),
      RelationshipStatusDurationScreen(),
      ParentStatusScreen(),
    ];
    _pageController = PageController();
    _currentIndex = 0;
    setButtonState(ref.read(authVM), _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthVM>(authVM, (previous, next) {
      setButtonState(next, _currentIndex);
    });
    return AsyncAwareWidget(
      inAsyncCall: ref.watch(authVM).busy,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Gap(24),
              Row(
                children: [
                  if (_currentIndex > 0)
                    TMIBackButton(
                      onPressed: () {
                        if (_currentIndex == 0) {
                          if (!ref.read(authVM).busy) {
                            ref.read(authVM).cleanRegistrationData();
                            context.pop();
                          }
                        } else {
                          _pageController.animateToPage(_currentIndex - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                    ),
                  const Spacer(),
                  TMICloseButton(
                    onPressed: () {
                      if (!ref.read(authVM).busy) {
                        ref.read(authVM).cleanRegistrationData();
                        context.pop();
                      }
                    },
                  )
                ],
              ),
              const Gap(24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    controller: _pageController,
                    children: _screens,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TMIButton(
                busy: ref.watch(authVM).busy,
                enabled: _buttonEnabled,
                buttonText: 'Continue',
                onPressed: () async {
                  if (_currentIndex == _screens.length - 1) {
                    await ref.read(authVM).personaliseProfile(context);
                  } else {
                    await _pageController
                        .animateToPage(
                          _currentIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        )
                        .then(
                          (_) =>
                              setButtonState(ref.read(authVM), _currentIndex),
                        );
                  }
                },
              ),
            ),
            const Gap(24)
          ],
        ),
      ),
    );
  }

  void setButtonState(AuthVM authVM, int index) {
    switch (index) {
      case 0:
        setState(() {
          _buttonEnabled = authVM.ageRange != null;
        });
        break;

      case 1:
        setState(() {
          _buttonEnabled = authVM.needToTalk != null;
        });
        break;
      case 2:
        setState(() {
          _buttonEnabled = authVM.relationshipStatus != null;
        });
        break;

      case 3:
        setState(() {
          _buttonEnabled = authVM.relationshipStatusDuration != null;
        });
        break;
      case 4:
        setState(() {
          _buttonEnabled = authVM.parentStatus != null;
        });
        break;
    }
  }

  bool showBackButton() {
    return true;
  }

  bool showCloseButton() {
    return true;
  }
}
