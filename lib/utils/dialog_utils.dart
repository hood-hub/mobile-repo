import 'package:flutter/material.dart';
import '../ui/widgets/custom_modal_dialog.dart';

void showCustomModalDialog({
  required BuildContext context,
  required Widget image,
  required String title,
  String? body,
  required String buttonText,
  required VoidCallback buttonAction,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomModalDialog(
        image: image,
        title: title,
        body: body,
        buttonText: buttonText,
        buttonAction: buttonAction,
      );
    },
  );
}
