import 'package:flutter/material.dart';
import 'package:hoodhub/ui/theme/text_styles.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final bool isPassword; // Added to indicate if the field is for passwords
  final int? maxLines;
  final Widget? prefixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.validator,
    this.onTap,
    this.maxLines = 1,
    this.prefixIcon,
    this.readOnly = false,
    this.isPassword = false, // Default value is false, meaning it's not a password field
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _error;
  bool _obscureText = true; // Track whether the text is obscured

  void _validate() {
    if (widget.validator != null) {
      final validationResult = widget.validator!(widget.controller.text);
      setState(() {
        _error = validationResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // 8px vertical margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.labelTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false, // Hide text if it's a password
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: widget.hintText,
              errorText: _error,
              prefix: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle obscure text
                  });
                },
              )
                  : null,
            ),
            onChanged: (value) {
              _validate(); // Validate as user types
            },
          ),
/*          if (widget.errorText != null || _error != null) ...[
            const SizedBox(height: 4),
            Text(
              _error ?? widget.errorText!,
              style: TextStyles.bodyLarge.copyWith(color: AppColors.errorTextColor),
            ),
          ],*/
        ],
      ),
    );
  }
}
