import 'package:flutter/material.dart';
import 'package:hoodhub/ui/theme/app_colors.dart';

class FilterRadioGroupWidget extends StatefulWidget {
  final List<String> options;
  final String? currentValue;
  final Function(String) onChanged;

  const FilterRadioGroupWidget({
    Key? key,
    required this.options,
    this.currentValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilterRadioGroupWidget> createState() => _FilterRadioGroupWidget();
}

class _FilterRadioGroupWidget extends State<FilterRadioGroupWidget> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    // If initialValue is null, use the first option (converted to lowercase)
    selectedValue = widget.currentValue ?? _formatString(widget.options.first);
  }



  String _formatString(String input) {
    // Convert to lowercase and replace spaces with dashes
    return input.toLowerCase().replaceAll(' ', '-');
  }

  @override
  Widget build(BuildContext context) {
    print(selectedValue);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.options.length,
            (index) {
          final option = widget.options[index];
          final value = _formatString(option);
          final isSelected = selectedValue == value;

          return Padding(
            padding: EdgeInsets.only(right: index < widget.options.length - 1 ? 10 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = value;
                });
                widget.onChanged(value);
              },
              child: Container(
                width: 77,
                height: 34,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFBD8EF7) : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.transparent : const Color(0xFFF1F1F3),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                child: Center(
                  child: Text(
                    option,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.grey500,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
