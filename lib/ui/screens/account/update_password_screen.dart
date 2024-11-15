import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/account_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updatePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New passwords don't match.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final body = {
      "prevPassword": _oldPasswordController.text,
      "newPassword": _newPasswordController.text,
    };

    final result = await ref.read(updatePasswordProvider(body: body).future);
    setState(() {
      _isLoading = false;
    });

    if (result != null) {
      showCustomModalDialog(
        context: context,
        image: SvgPicture.asset('assets/images/celebration-ic.svg'),
        title: 'Password Updated Successfully',
        buttonText: 'Go to Homepage',
        buttonAction: () => context.pop(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update password. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      title: 'Update Password',
      buttonText: 'Update password',
      buttonAction: _updatePassword,
      customButton: CustomButton(
        text: 'Update password',
        onPressed: _updatePassword,
        color: AppColors.primary,
        isLoading: _isLoading, // Pass the loading state to CustomButton
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: _oldPasswordController,
            hintText: 'Enter old password',
            labelText: 'Old Password*',
            isPassword: true,
          ),
          CustomTextField(
            controller: _newPasswordController,
            hintText: 'Enter new password',
            labelText: 'New Password*',
            isPassword: true,
          ),
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: 'Re-enter new password',
            labelText: 'Confirm New Password*',
            isPassword: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
