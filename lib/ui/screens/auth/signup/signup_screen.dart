import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/dio_providers/dio_provider.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/base_flow_screen.dart';
import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Loading state

  @override
  Widget build(BuildContext context) {
    // Get AuthService from provider
    final authService = ref.read(authServiceProvider);

    return BaseFlowScreen(
      buttonText: 'Next',
      buttonAction: isLoading
          ? null // Disable the button while loading
          : () async {
        // Implement form validation logic
        if (firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty ||
            emailController.text.isEmpty ||
            passwordController.text.length < 8) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all fields correctly')),
          );
          return;
        }

        setState(() {
          isLoading = true; // Start loading
        });

        try {
          // Call the signup method
          bool isSignedUp = await authService.signup(
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            passwordController.text,
          );

          if (isSignedUp) {
            // Show the email verification modal
            showCustomModalDialog(
              context: context,
              image: SvgPicture.asset('assets/images/email-ic.svg'),
              title: 'Email Verification',
              body: "We've sent a verification link to ${emailController.text}",
              buttonText: 'Check mailbox',
              buttonAction: () {
                // Navigate to the verification screen upon clicking the button
                context.push('/verification?email=${emailController.text}');
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signup failed. Please try again.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        } finally {
          setState(() {
            isLoading = false; // Stop loading
          });
        }
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tell us about you',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey800,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'Enter your first name',
                  labelText: 'First Name*',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: lastNameController,
                  hintText: 'Enter your last name',
                  labelText: 'Last Name*',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email*',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Create a password',
                  labelText: 'Password*',
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
/*            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),*/
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
