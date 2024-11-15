import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';

class BaseFlowScreen extends StatefulWidget {
  final String? title; // Optional title
  final String buttonText;
  final VoidCallback? buttonAction; // Make it nullable
  final Widget? customButton;
  final VoidCallback? backAction;
  final Widget child;

  const BaseFlowScreen({
    Key? key,
    this.title, // Add title to constructor
    required this.buttonText,
    this.buttonAction, // Make buttonAction nullable
    required this.child,
    this.customButton,
    this.backAction,
  }) : super(key: key);

  @override
  State<BaseFlowScreen> createState() => _BaseFlowScreenState();
}

class _BaseFlowScreenState extends State<BaseFlowScreen> {
  @override
  Widget build(BuildContext context) {
    // Set the status bar to light mode
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Dark icons for a light background
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary, // Back button icon color
          ),
          onPressed: () {
            if (widget.backAction != null) {
              widget.backAction!();
            } else {
              context.pop();
            }
          },
        ),
        title: widget.title != null
            ? Text(
          widget.title!,
          style: const TextStyle(
            color: AppColors.grey900, // Title color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
            : null, // Show title only if it's not null
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Page padding for left and right sides
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.child,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 20, right: 20), // Padding from the bottom
        child: widget.customButton ??
            CustomButton(
              text: widget.buttonText,
              onPressed: widget.buttonAction ?? () {}, // If action is null, set empty callback to prevent error
              color: widget.buttonAction == null ? Colors.grey : AppColors.primary, // Set color based on action
            ),
      ),
    );
  }
}
