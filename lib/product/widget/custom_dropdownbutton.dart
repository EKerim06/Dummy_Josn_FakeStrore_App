import 'package:flutter/material.dart';

///Custom Dropdownbutton
class CustomDropdownbutton extends StatefulWidget {
  ///Custom Dropdownbutton constructor
  const CustomDropdownbutton({
    required this.items,
    required this.selectedCategories,
    super.key,
  });

  ///Custom Dropdownbutton constructor
  final List<String> items;

  ///Custom Dropdownbutton constructor return value [String]
  final void Function(String categories) selectedCategories;

  @override
  State<CustomDropdownbutton> createState() => _CustomDropdownbuttonState();
}

class _CustomDropdownbuttonState extends State<CustomDropdownbutton> {
  String initialValue = 'All';

  void _onChange(String? value) {
    if (value?.isEmpty ?? true) return;
    setState(() {
      initialValue = value!;
    });
    widget.selectedCategories(value!);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownbutton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items != oldWidget.items && widget.items.isNotEmpty) {
      _onChange(widget.items.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      onChanged: _onChange,
      items: widget.items.map(
        (e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        },
      ).toList(),
    );
  }
}
