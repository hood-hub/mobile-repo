import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome-bg.jpeg', // Background image of neighborhood
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to HoodHub',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your neighborhood is about to get a whole lot friendlier.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'New Here? Create an account',
                      color: AppColors.buttonBackground,
                      onPressed: () {
                        context.push('/sign-up');
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Already have an account? Log in',
                      color: AppColors.greyf1,
                      borderColor: AppColors.greyf1,
                      onPressed: () {
                        context.push('/login');
                      },
                      isOutlined: true,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Sign in with Google',
                      textColor: AppColors.googleButtonColor,
                      isOutlined: true,
                      onPressed: () {
                        // Handle Google Sign-In logic here
                        //context.push('/username');
                      },
                      prefixIcon: SvgPicture.asset(
                        'assets/images/google-logo.svg', // Google logo
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
