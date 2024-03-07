// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class TMITextField extends StatefulWidget {
  const TMITextField({
    Key? key,
    this.controller,
    this.enabled = true,
    this.autoFocus = false,
    this.inputType,
    this.autofillHints,
    this.inputAction,
    this.focusNode,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.labelText = '',
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.inputFormatters,
    this.onChanged,
    this.readOnly = false,
    this.isRequiredField = false,
    this.onSaved,
    this.isPasswordField = false,
    this.obscure = false,
    this.hintText = '',
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool autoFocus;
  final List<String>? autofillHints;
  final bool obscure;
  final List<TextInputFormatter>? inputFormatters;
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool isRequiredField;
  final bool isPasswordField;

  @override
  _TMITextFieldState createState() => _TMITextFieldState();
}

class _TMITextFieldState extends State<TMITextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(
          5,
        ),
        TextFormField(
          autofocus: widget.autoFocus,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
          style: AppStyles.getTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: widget.enabled ? kTitleActiveColor : kBodyColor,
          ),
          obscureText: obscure,
          keyboardType: widget.inputType,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          maxLines: widget.isPasswordField ? 1 : widget.maxLines,
          controller: widget.controller,
          textInputAction: widget.inputAction,
          textCapitalization: widget.textCapitalization!,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: AppStyles.getTextStyle(
              color: const Color(0xffC4C4C4),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            labelText: widget.labelText,
            suffixIcon: widget.suffixIcon ?? getSuffixIcon(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
              maxHeight: 50,
              maxWidth: 50,
            ),
            fillColor: const Color(0xffEFF0F6),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            hintStyle: AppStyles.getTextStyle(
              color: const Color(0xffC4C4C4),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            hintText: widget.isPasswordField ? '*********' : widget.hintText,
            errorStyle: const TextStyle(color: Colors.red),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimaryColor, width: .8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: kLightGrey.withOpacity(.1),
                width: .8,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red[300]!, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red[300]!, width: 1.2),
            ),
          ),
        )
      ],
    );
  }

  Widget getSuffixIcon() {
    if (!widget.isPasswordField) {
      return const SizedBox();
    } else {
      if (obscure) {
        return GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(),
          ),
        );
      }
    }
  }
}

class TMISearchBox extends StatefulWidget {
  const TMISearchBox({
    Key? key,
    this.controller,
    this.enabled = true,
    this.autoFocus = false,
    this.inputType,
    this.autofillHints,
    this.inputAction,
    this.focusNode,
    this.maxLength,
    this.labelText = 'Search',
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.inputFormatters,
    this.onSubmitted,
    this.onChanged,
    this.readOnly = false,
    this.showClearIcon = false,
    this.onSaved,
    this.onInputCleared,
    this.hintText = 'Search',
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool enabled;
  final bool autoFocus;
  final List<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly;
  final bool showClearIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  final void Function(String?)? onSaved;
  final void Function()? onInputCleared;

  @override
  _TMISearchBoxState createState() => _TMISearchBoxState();
}

class _TMISearchBoxState extends State<TMISearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onSubmitted,
      cursorColor: kPrimaryColor,
      onChanged: widget.onChanged,
      style: AppStyles.getTextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: kBodyColor,
      ),
      keyboardType: TextInputType.text,
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
          color: Colors.black,
        ),
        suffixIcon: widget.showClearIcon
            ? widget.suffixIcon ??
                GestureDetector(
                  onTap: () {
                    widget.controller?.clear();
                    widget.onInputCleared?.call();
                  },
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 20,
                  ),
                )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
          maxHeight: 50,
          maxWidth: 50,
        ),
        fillColor: kInputBGColor.withOpacity(.5),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle: AppStyles.getTextStyle(
          color: kPlaceHolderColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        hintText: widget.hintText,
        errorStyle: const TextStyle(color: Colors.red),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent, width: .8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xffF9F9F9),
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red[300]!, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red[300]!, width: 1.2),
        ),
      ),
    );
  }
}
