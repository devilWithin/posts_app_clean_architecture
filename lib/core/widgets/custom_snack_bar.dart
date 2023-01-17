import 'package:flutter/material.dart';

class CustomSnackBar {
  void showSuccessSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
