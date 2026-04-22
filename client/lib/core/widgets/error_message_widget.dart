import 'package:flutter/material.dart';

enum ErrorDisplayType { snackbar, banner, inline }

class ErrorMessageWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onDismiss;
  final ErrorDisplayType displayType;

  const ErrorMessageWidget({
    super.key,
    this.errorMessage,
    this.onDismiss,
    this.displayType = ErrorDisplayType.snackbar,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null || errorMessage!.isEmpty) {
      return const SizedBox.shrink();
    }

    switch (displayType) {
      case ErrorDisplayType.snackbar:
        return _buildSnackBar(context);
      case ErrorDisplayType.banner:
        return _buildBanner();
      case ErrorDisplayType.inline:
        return _buildInline();
    }
  }

  Widget _buildSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Error occurred'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: onDismiss ?? () {},
          ),
        ),
      );
    });
    return const SizedBox.shrink();
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        border: Border(left: BorderSide(color: Colors.red.shade700, width: 4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              errorMessage ?? 'Error occurred',
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: Colors.red.shade700),
            ),
        ],
      ),
    );
  }

  Widget _buildInline() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              errorMessage ?? 'Error occurred',
              style: TextStyle(color: Colors.red.shade900, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
