import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class WrappedCheckItemsPicker extends StatefulWidget {
  const WrappedCheckItemsPicker(
      {Key? key,
      this.items = const [],
      required this.onChanged,
      this.runAlignment = WrapAlignment.start,
      this.alignment = WrapAlignment.center,
      this.wrapCrossAlignment = WrapCrossAlignment.start})
      : super(key: key);
  final List<String> items;
  final void Function(List<String>) onChanged;
  final WrapAlignment alignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final WrapAlignment runAlignment;

  @override
  _WrappedCheckItemsPickerState createState() =>
      _WrappedCheckItemsPickerState();
}

class _WrappedCheckItemsPickerState extends State<WrappedCheckItemsPicker> {
  Set<String> _pickedItem = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        crossAxisAlignment: widget.wrapCrossAlignment,
        alignment: widget.alignment,
        runAlignment: widget.runAlignment,
        spacing: 6,
        runSpacing: 12,
        children: widget.items.map(buildChip).toList(),
      ),
    );
  }

  Widget buildChip(String text) {
    final isSelected = _pickedItem.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? _pickedItem.remove(text) : _pickedItem.add(text);
        });
        widget.onChanged(_pickedItem.toList());
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? kSecondaryColor
                : kPlaceHolderColor.withOpacity(.8),
            width: .8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                value: isSelected,
                onChanged: (value) {},
                checkColor: kWhite,
                activeColor: kSecondaryColor,
              ),
            ),
            Text(
              text,
              style: AppStyles.getTextStyle(
                  color: isSelected ? kSecondaryColor : kPlaceHolderColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            const Gap(12)
          ],
        ),
      ),
    );
  }
}

class WrappedCheckItemPicker extends StatefulWidget {
  const WrappedCheckItemPicker(
      {Key? key,
      this.items = const [],
      required this.onChanged,
      this.runAlignment = WrapAlignment.start,
      this.alignment = WrapAlignment.center,
      this.wrapCrossAlignment = WrapCrossAlignment.start})
      : super(key: key);
  final List<String> items;
  final void Function(String?) onChanged;
  final WrapAlignment alignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final WrapAlignment runAlignment;

  @override
  _WrappedCheckItemPickerState createState() => _WrappedCheckItemPickerState();
}

class _WrappedCheckItemPickerState extends State<WrappedCheckItemPicker> {
  String? _pickedItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        crossAxisAlignment: widget.wrapCrossAlignment,
        alignment: widget.alignment,
        runAlignment: widget.runAlignment,
        spacing: 6,
        runSpacing: 12,
        children: widget.items.map(buildChip).toList(),
      ),
    );
  }

  Widget buildChip(String text) {
    final isSelected = _pickedItem == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _pickedItem = text;
        });
        widget.onChanged(_pickedItem);
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? kSecondaryColor
                : kPlaceHolderColor.withOpacity(.8),
            width: .8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                value: isSelected,
                onChanged: (value) {},
                checkColor: kWhite,
                activeColor: kSecondaryColor,
              ),
            ),
            Text(
              text,
              style: AppStyles.getTextStyle(
                  color: isSelected ? kSecondaryColor : kPlaceHolderColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            const Gap(12)
          ],
        ),
      ),
    );
  }
}
