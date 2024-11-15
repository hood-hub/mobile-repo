import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/snackbar_utils.dart';
import '../../widgets/widgets.dart';
import '../../theme/app_colors.dart';


class ResetPasswordTokenScreen extends ConsumerStatefulWidget {
  final String email;

  ResetPasswordTokenScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordTokenScreenState createState() => _ResetPasswordTokenScreenState();
}

class _ResetPasswordTokenScreenState extends ConsumerState<ResetPasswordTokenScreen> {
  final TextEditingController tokenController = TextEditingController();

  Future<void> _next() async {
    if (tokenController.text.isEmpty || tokenController.text.length < 6) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Please enter a valid 6-digit code.',
        backgroundColor: Colors.red,
      );
      return;
    }

    context.push('/reset-password-new/?email=${widget.email}&token=${int.parse(tokenController.text)}');
  }

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      buttonText: 'Next',
      buttonAction: _next,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Enter Verification Code',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: tokenController,
            hintText: 'Enter code',
            labelText: 'Enter code',
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Code must be 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }
}
