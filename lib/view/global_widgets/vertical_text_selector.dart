import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class VerticalItem<T> {
  VerticalItem({required this.value, required this.text});

  final T value;
  final String text;
}

class ColumnItemsSelector<T> extends StatefulWidget {
  const ColumnItemsSelector({
    Key? key,
    this.items = const [],
    required this.onChanged,
    this.value,
    this.borderWidth = 1,
    this.borderColor = kPrimaryColor,
    this.verticalSpacing = 10,
    this.unSelectedBorderColor = kLineColor,
  }) : super(key: key);
  final List<VerticalItem<T>> items;
  final void Function(T) onChanged;
  final T? value;
  final Color borderColor;
  final double borderWidth;
  final Color unSelectedBorderColor;
  final double verticalSpacing;

  @override
  _ColumnItemsSelectorState<T> createState() => _ColumnItemsSelectorState<T>();
}

class _ColumnItemsSelectorState<T> extends State<ColumnItemsSelector<T>> {
  late T? _currentValue;

  @override
  void initState() {
    _currentValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: widget.verticalSpacing),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentValue = item.value;
                      widget.onChanged(item.value);
                    });
                  },
                  child: CategoryItem(
                    text: item.text,
                    selected: _currentValue == item.value,
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, this.selected = false, required this.text})
      : super(key: key);
  final bool selected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      // width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: kWhite,
        border:
            Border.all(color: selected ? kPrimaryColor : kLineColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppStyles.getTextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: selected ? kPrimaryColor : kLabelColor),
            ),
          ),
        ],
      ),
    );
  }
}
