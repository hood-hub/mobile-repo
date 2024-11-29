// lib/src/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/dio_providers/dio_provider.dart';
import '../../../../utils/snackbar_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/base_flow_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _login() async {
    if (widget.emailController.text.isEmpty || widget.passwordController.text.isEmpty) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Please enter both email and password.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      bool loginSuccess = await authService.login(
        widget.emailController.text,
        widget.passwordController.text,
      );

      if (loginSuccess) {
        // Navigate to the next screen after a successful login
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Login Successful.',
          backgroundColor: Colors.green,
        );
        context.go('/bottom-nav');
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Login failed. Please check your credentials and try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'An error occurred during login: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      buttonText: _isLoading ? 'Logging in...' : 'Next',
      buttonAction: _isLoading ? null : _login,
      backAction: () {
        context.go('/welcome');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: widget.emailController,
            hintText: 'Enter your email',
            labelText: 'Email*',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: widget.passwordController,
            hintText: 'Enter password',
            labelText: 'Password*',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
            isPassword: true,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Logic for "Forgot Password?" action
                  context.push('/reset-password');
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }
}