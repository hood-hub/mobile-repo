import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class TermsOfUseScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseFlowScreen(
      title: 'Terms of Use',
      buttonText: 'Agree', // No custom button from BaseFlowScreen
      buttonAction: () => context.pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTermItem("1. User Agreement", "By using our neighborhood app, you agree to these terms and conditions..."),
          const SizedBox(height: 16),
          _buildTermItem("2. Community Guidelines", "Our community thrives on respect, transparency, and cooperation..."),
          const SizedBox(height: 16),
          _buildTermItem("3. Privacy Policy", "We take your privacy seriously. Here's how we handle your data..."),
        ],
      ),
    );
  }

  Widget _buildTermItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
