import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/base_flow_screen.dart';
import '../../widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      buttonText: 'Next',
      buttonAction: () {
        context.push('/sign-up'); // Use GoRouter to navigate to the Sign-Up Screen
      },
      customButton: CustomButton(
        text: 'Next',
        color: AppColors.primary,
        onPressed: () {
          context.push('/sign-up'); // Use GoRouter to navigate to the Sign-Up Screen
        },
      ),
      backAction: () {
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            "Let's get you set up in just a few\n"
                "easy steps.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.grey800,
            ),
          ),
          const SizedBox(height: 40,),
          Center(
            child: SvgPicture.asset(
              'assets/images/onboard-ic.svg', // Replace with actual image path
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
