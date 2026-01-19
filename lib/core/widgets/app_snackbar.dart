import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        // لو Error بس نغيّر اللون، غير كده سيب الثيم
        backgroundColor: isError ? const Color(0xFFB00020) : null,
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
