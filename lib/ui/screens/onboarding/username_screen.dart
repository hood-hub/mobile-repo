import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/snackbar_utils.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  final String userId;

  UsernameScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController usernameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _next() async {
    if (usernameController.text.isEmpty) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Please enter a username.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    context.push('/select-address/?userId=${widget.userId}&username=${usernameController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      buttonText: _isLoading ? 'Loading...' : 'Next',
      buttonAction: _isLoading ? null : _next,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Pick a username',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: usernameController,
            hintText: 'Enter a preferred username',
            labelText: 'Username*',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
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
    usernameController.dispose();
    super.dispose();
  }
}
