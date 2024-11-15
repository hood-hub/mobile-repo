import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showTopSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black,
    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  }) {
    OverlayState overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20, // Show below the status bar
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: textStyle,
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    overlayState.insert(overlayEntry);

    // Remove the overlay entry after the specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
