import 'package:client/core/styles/styles.dart';
import 'package:flutter/material.dart';

enum InputWidgetType { text, password, email }

class InputWidget extends StatelessWidget {
  final InputWidgetType type;
  final String label;
  final Key? inputKey;
  final String? errText;
  final void Function(String)? onChanged;
  final bool obscureText;

  const InputWidget({
    super.key,
    required this.label,
    this.onChanged,
    this.type = InputWidgetType.text,
    this.inputKey,
    this.obscureText = false,
    this.errText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(label, style: kInputLabelLight),
        ),
        const Padding(padding: EdgeInsets.all(2)),
        TextField(
          key: inputKey,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(errorText: errText),
        ),
      ],
    );
  }
}
