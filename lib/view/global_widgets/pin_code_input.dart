import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:pinput/pinput.dart';

class TMIPinWidget extends StatelessWidget {
   TMIPinWidget({
    Key? key,
    this.pinController,
    this.onSubmit,
    this.onChanged,
    this.useNativeKeypad = true,
  }) : super(key: key);

  final TextEditingController? pinController;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final bool useNativeKeypad;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: kTitleActiveColor),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  final selectedFieldTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: kTitleActiveColor),
    decoration: BoxDecoration(
      border: Border.all(color: kPrimaryColor, width: .5),
      color: const Color(0xffF9F9F9),
      borderRadius: BorderRadius.circular(4),
    ),
  );
  final disabledTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: kTitleActiveColor),
    decoration: BoxDecoration(
      border: Border.all(color: kLightGrey.withOpacity(.3)),
      color: const Color(0xffF9F9F9),
      borderRadius: BorderRadius.circular(4),
    ),
  );
  final followingFieldTheme = PinTheme(
    width: 56,
    height: 56,
    padding:  const EdgeInsets.all(8),
    textStyle: TextStyle(fontSize: 20, color: kTitleActiveColor),
    decoration: BoxDecoration(
      border: Border.all(color: kLightGrey.withOpacity(.3)),
      color: const Color(0xffF9F9F9),
      borderRadius: BorderRadius.circular(4),
    ),
  );
  final submittedFieldTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: kTitleActiveColor),
    decoration: BoxDecoration(
      border: Border.all(color: kPrimaryColor),
      color: const Color(0xffF9F9F9),
      borderRadius: BorderRadius.circular(4),
    ),

  );



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Pinput(
        useNativeKeyboard: useNativeKeypad,
        onChanged: onChanged,
      defaultPinTheme: defaultPinTheme,
        disabledPinTheme: disabledTheme,
        submittedPinTheme: submittedFieldTheme,
        followingPinTheme: followingFieldTheme,
        focusedPinTheme: selectedFieldTheme,
        controller: pinController,
        onSubmitted: onSubmit,
        onCompleted: onSubmit,
        autofocus: true,
        length: 5,



      ),
    );
  }
}
