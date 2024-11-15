import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/snackbar_utils.dart';
import '../../widgets/widgets.dart';
import '../../theme/app_colors.dart';

class ResetPasswordScreen2 extends ConsumerStatefulWidget {
  final TextEditingController passwordController = TextEditingController();
  final String email;
  final int token;

  ResetPasswordScreen2({Key? key, required this.email, required this.token}) : super(key: key);

  @override
  _ResetPasswordScreen2State createState() => _ResetPasswordScreen2State();
}

class _ResetPasswordScreen2State extends ConsumerState<ResetPasswordScreen2> {
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (widget.passwordController.text.isEmpty || widget.passwordController.text.length < 8) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Password must be at least 8 characters.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      bool isPasswordReset = await authService.resetPassword(
        email: widget.email,
        token: widget.token,
        newPassword: widget.passwordController.text,
      );

      if (isPasswordReset) {
        showCustomModalDialog(
          context: context,
          image: SvgPicture.asset('assets/images/celebration-ic.svg'),
          title: 'Password Changed Successfully',
          buttonText: 'Go to Login page',
          buttonAction: () {
            context.push('/login');
          },
        );
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Failed to reset password. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'An error occurred: $e',
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
      buttonText: _isLoading ? 'Processing...' : 'Confirm',
      buttonAction: _isLoading ? null : _resetPassword,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Reset password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Forgotten your password? Let's help you get it back.",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: widget.passwordController,
            hintText: 'Enter new password',
            labelText: 'Enter new password',
            isPassword: true,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}