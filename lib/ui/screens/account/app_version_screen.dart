import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class AppVersionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseFlowScreen(
      title: 'App Version',
      buttonText: '', // No custom button from BaseFlowScreen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "App Information",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Version", style: const TextStyle(color: AppColors.textSecondary)),
              Text("1.0.0", style: const TextStyle(color: AppColors.textSecondary)),
              Text("Build", style: const TextStyle(color: AppColors.textSecondary)),
              Text("1.0.1", style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "What's New",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            "• Enhanced security features\n• Bug fixes and improvements\n• Updated community features",
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Check for updates',
            onPressed: () {
              // Check for updates action
            },
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
