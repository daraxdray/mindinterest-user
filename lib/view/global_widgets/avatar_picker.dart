import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker(
      {Key? key,
      required this.onImageSelected,
      this.size = 52,
      this.fit,
      this.initialNetworkImage,
      this.emptyWidget,
      this.text = 'Change profile photo'})
      : super(key: key);
  final void Function(File file) onImageSelected;
  final double size;
  final BoxFit? fit;
  final String? initialNetworkImage;
  final String? text;
  final Widget? emptyWidget;

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File? _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Container(
            color: kLightGrey,
            height: widget.size,
            width: widget.size,
            child: _pickedFile == null
                ? widget.initialNetworkImage != null
                    ? AppNetworkImage(
                        url: widget.initialNetworkImage!,
                      )
                    : widget.emptyWidget ??
                        Image.asset(
                          'assets/images/user_avatar.png',
                          fit: widget.fit,
                        )
                : Image.file(
                    _pickedFile!,
                    fit: widget.fit,
                  ),
          ),
        ),
        const Gap(4),
        TextButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles();

            if (result != null) {
              setState(() {
                _pickedFile = File(result.files[0].path!);
              });
              widget.onImageSelected(_pickedFile!);
            } else {
              // User canceled the picker
            }
          },
          child: Text(
            widget.text ?? 'Change profile photo',
            style: AppStyles.getTextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: kPrimaryDark),
          ),
        )
      ],
    );
  }
}
