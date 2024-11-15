import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/account_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../../utils/dialog_utils.dart';
import '../../widgets/base_flow_screen.dart';

class EmergencyContactScreen extends ConsumerStatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends ConsumerState<EmergencyContactScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  List<TextEditingController> _additionalPhoneControllers = [];
  bool _isLoading = false;

  Future<void> _saveEmergencyContact() async {
    setState(() => _isLoading = true);

    final body = {
      "emergencyContact": {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "relationship": _relationshipController.text,
        "phoneNumber": _phoneNumberController.text,
        "email": _emailController.text,
        "isPrimary": false,
      }
    };

    final result = await ref.read(updateEmergencyContactProvider(body: body).future);
    setState(() => _isLoading = false);

    if (result != null) {
      showCustomModalDialog(
        context: context,
        image: SvgPicture.asset('assets/images/celebration-ic.svg'), // Replace with your success icon
        title: 'Emergency contact Saved',
        buttonText: 'Go back',
        buttonAction: () => context.pop(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save contact. Please try again.')),
      );
    }
  }

  void _addPhoneNumberField() {
    setState(() {
      _additionalPhoneControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _relationshipController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    for (var controller in _additionalPhoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      title: 'Emergency Contact',
      buttonText: 'Save',
      customButton: CustomButton(
        text: 'Save',
        onPressed:  _saveEmergencyContact,
        isLoading: _isLoading, // Use loading indicator
        color: _isLoading ? Colors.grey : AppColors.primary,
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: _firstNameController,
            hintText: 'Enter contact first name',
            labelText: 'First Name*',
          ),
          CustomTextField(
            controller: _lastNameController,
            hintText: 'Enter contact last name',
            labelText: 'Last Name*',
          ),
          CustomTextField(
            controller: _relationshipController,
            hintText: 'Enter relationship title',
            labelText: 'Relationship*',
          ),
          CustomTextField(
            controller: _emailController,
            hintText: 'Enter contact email',
            labelText: 'Email*',
          ),
          CustomTextField(
            controller: _phoneNumberController,
            hintText: 'Enter contact mobile number',
            labelText: 'Phone Number*',
          ),
          const SizedBox(height: 16),
          for (var controller in _additionalPhoneControllers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomTextField(
                controller: controller,
                hintText: 'Enter additional mobile number',
                labelText: 'Additional Phone Number',
              ),
            ),
          GestureDetector(
            onTap: null/*_addPhoneNumberField*/,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add, color: AppColors.primary),
                SizedBox(width: 4),
                Text(
                  'Add more',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
