import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class ContactSupportScreen extends ConsumerWidget {
  final TextEditingController _issueTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseFlowScreen(
      title: 'Contact Support',
      buttonText: 'Submit Support Ticket', // No custom button from BaseFlowScreen
      buttonAction: () => context.pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: _issueTypeController,
            hintText: 'Enter issue type',
            labelText: 'Issue Type*',
          ),
          CustomTextField(
            controller: _descriptionController,
            hintText: 'Please describe your issue',
            labelText: 'Description*',
            maxLines: 5, // For multiline input
          ),
        ],
      ),
    );
  }
}
