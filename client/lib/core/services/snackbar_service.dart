import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class SnackBarService {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    print("snakcbar show ${message}");
    messengerKey.currentState?.hideCurrentSnackBar();
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            _getIcon(type),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: _getBackgroundColor(type),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static Widget _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case SnackBarType.error:
        return const Icon(Icons.error_outline, color: Colors.white);
      case SnackBarType.warning:
        return const Icon(Icons.warning_amber_rounded, color: Colors.white);
      case SnackBarType.info:
        return const Icon(Icons.info_outline, color: Colors.white);
    }
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green.shade600;
      case SnackBarType.error:
        return Colors.red.shade600;
      case SnackBarType.warning:
        return Colors.orange.shade600;
      case SnackBarType.info:
        return Colors.blue.shade600;
    }
  }
}
