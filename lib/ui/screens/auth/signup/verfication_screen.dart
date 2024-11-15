import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/dio_providers/dio_provider.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../../utils/snackbar_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/base_flow_screen.dart';
import '../../../widgets/custom_text_field.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final TextEditingController codeController = TextEditingController();
  final String email;  // Required email

  VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  bool _isLoading = false;
  bool _canResend = false;
  int _countdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  Future<void> _verifyCode() async {
    if (widget.codeController.text.isEmpty || widget.codeController.text.length < 6) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Invalid code. Please enter a 6-digit code.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dioService = ref.read(dioServiceProvider);
      Response response = await dioService.postRequest(
        '/api/v1/user/verify',
        data: {'email': widget.email, 'token': int.parse(widget.codeController.text)},
      );


      if (response.statusCode == 200) {
        final String userId = response.data['data']['_id'];
        // Show email verified modal
        showCustomModalDialog(
          context: context,
          image: SvgPicture.asset('assets/images/celebration-ic.svg'),
          title: 'Email Verified',
          buttonText: 'Next',
          buttonAction: () {
            context.push('/username?userId=$userId');
          },
        );
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Verification failed. Please check the code and try again.',
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

  Future<void> _resendCode() async {
    if (!_canResend) return;

    setState(() {
      _isLoading = true;
      _canResend = false;
      _countdown = 60;
    });

    try {
      final dioService = ref.read(dioServiceProvider);
      final response = await dioService.postRequest(
        '/api/v1/user/resend-token',
        data: {'emailOrUsername': widget.email},
      );

      if (response.statusCode == 200) {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Verification code resent successfully.',
          backgroundColor: Colors.green,
        );
        _startCountdown();
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Failed to resend verification code. Please try again.',
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
      buttonText: _isLoading ? 'Verifying...' : 'Next',
      buttonAction: _isLoading ? null : _verifyCode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Two Factor Authentication (2FA) Verification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: widget.codeController,
            hintText: 'Enter code',
            labelText: 'Enter code',
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Code must be 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Didn't receive the code?",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _canResend ? _resendCode : null,
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    fontSize: 14,
                    color: _canResend ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '$_countdown s',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
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
    widget.codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}