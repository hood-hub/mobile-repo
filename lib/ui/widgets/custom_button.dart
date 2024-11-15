import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color; // Made color optional
  final Color? borderColor;
  final Color? textColor; // Added textColor argument
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Widget? prefixIcon;
  final double? width; // New width parameter
  final double? height;
  final EdgeInsets padding; // Custom padding argument
  final TextStyle? textStyle; // Custom TextStyle argument
  final double? fontSize;
  final bool isLoading; // Loading state for the button

  const CustomButton({
    Key? key,
    required this.text,
    this.color,
    this.borderColor,
    this.textColor,
    required this.onPressed,
    this.isOutlined = false,
    this.prefixIcon,
    this.width, // Initialize width parameter
    this.height,
    this.padding = const EdgeInsets.symmetric(vertical: 16), // Default padding
    this.textStyle, // Initialize textStyle
    this.fontSize,
    this.isLoading = false, // Default is not loading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // Use the provided width or default to full width
      height: height ?? null,
      child: isOutlined ? _buildOutlinedButton() : _buildElevatedButton(),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button if loading
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primary, // Default to primary color
        foregroundColor: textColor ?? AppColors.white, // Default to white text color
        padding: padding, // Use custom padding or default
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed, // Disable button if loading
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary, // Default text color is primary
        side: BorderSide(color: borderColor ?? AppColors.greyf1), // Default to outlinedButtonTextColor
        padding: padding, // Use custom padding or default
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white, // Customize color as needed
          strokeWidth: 2,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: fontSize ?? 18,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? (isOutlined ? AppColors.primary : AppColors.white),
                ), // Use custom textStyle or default
          ),
        ],
      );
    }
  }
}
