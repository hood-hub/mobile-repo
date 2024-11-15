import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_button.dart';

class CustomModalDialog extends StatelessWidget {
  final Widget image;
  final String title;
  final String? body;
  final String buttonText;
  final VoidCallback buttonAction;

  const CustomModalDialog({
    Key? key,
    required this.image,
    required this.title,
    this.body,
    required this.buttonText,
    required this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 16 pixels padding around the content
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image,
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (body != null) ...[
              const SizedBox(height: 8),
              Text(
                body!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            CustomButton(
              text: buttonText,
              onPressed: () {
                buttonAction();
                Navigator.of(context).pop(); // Close the dialog after button press
              },
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
