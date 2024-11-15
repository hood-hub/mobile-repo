import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/snackbar_utils.dart';
import '../../widgets/widgets.dart';
import '../../theme/app_colors.dart';

class ResetPasswordScreen1 extends ConsumerStatefulWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordScreen1({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreen1State createState() => _ResetPasswordScreen1State();
}

class _ResetPasswordScreen1State extends ConsumerState<ResetPasswordScreen1> {
  bool _isLoading = false;

  Future<void> _sendResetCode() async {
    if (widget.emailController.text.isEmpty) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Please enter your email or username.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      bool isCodeSent = await authService.forgotPassword(widget.emailController.text);

      if (isCodeSent) {
        showCustomModalDialog(
          context: context,
          image: SvgPicture.asset('assets/images/email-ic.svg'),
          title: 'Email Verification',
          body: "We've sent a verification link to ${widget.emailController.text}",
          buttonText: 'Check mailbox',
          buttonAction: () {
            context.push('/reset-password-token/?email=${widget.emailController.text}');
          },
        );
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Failed to send reset code. Please try again.',
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
      buttonText: _isLoading ? 'Sending...' : 'Send Code',
      buttonAction: _isLoading ? null : _sendResetCode,
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
            controller: widget.emailController,
            hintText: 'Enter your email or username',
            labelText: 'Email or Username*',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email or username';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}