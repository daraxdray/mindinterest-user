
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/async_aware.dart';
import 'package:mindintrest_user/view/global_widgets/avatar_picker.dart';
import 'package:mindintrest_user/view/global_widgets/decorated_page.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';

class EditProfileScreen extends StatefulHookConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late String initialFirstName;
  late String initialLastName;
  late TextEditingController _lNameCon;
  late TextEditingController _fNameCon;
  // File? pickedImage;

  bool _buttonEnabled = false;

  @override
  void initState() {
    final names = ref.read(userProvider).name?.split(' ');
    initialFirstName = names![1];
    initialLastName = names[0];
    _lNameCon = TextEditingController(text: initialLastName);
    _fNameCon = TextEditingController(text: initialFirstName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncAwareWidget(
      inAsyncCall: ref.watch(authVM).busy,
      child: TMIDecoratedPage(
          showCloseButton: false,
          showBackButton: true,
          title: 'Edit Profile',
          child: Column(
            children: [
              AvatarPicker(
                initialNetworkImage: ref.watch(userProvider).profileImg,
                size: 100,
                onImageSelected: (file) async {
                  await ref.read(authVM).uploadProfileImage(context, file);
                },
              ),
              const Gap(24),
              TMITextField(
                onChanged: (_) {
                  setButtonState();
                },
                controller: _lNameCon,
                hintText: 'Last name',
              ),
              const Gap(12),
              TMITextField(
                onChanged: (_) {
                  setButtonState();
                },
                controller: _fNameCon,
                hintText: 'First name',
              ),
              const Gap(24),
              SizedBox(
                width: 140,
                child: TMIButton(
                  busy: ref.watch(authVM).busy,
                  enabled: _buttonEnabled,
                  onPressed: () {
                    ref.read(authVM).updateProfile(context,
                        fName: _fNameCon.text, lName: _lNameCon.text);
                  },
                  buttonText: 'Save',
                ),
              )
            ],
          )),
    );
  }

  void setButtonState() {
    final valuesChanged = !(_lNameCon.text == initialLastName &&
        _fNameCon.text == initialFirstName);

    final validInput = _lNameCon.text.length >= 3 && _fNameCon.text.length >= 3;

    setState(() {
      _buttonEnabled = (valuesChanged && validInput) == true;
    });
  }
}
