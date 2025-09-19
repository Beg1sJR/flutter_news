import 'package:flutter/material.dart';

class BuildErrorText extends StatelessWidget {
  const BuildErrorText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 16),
        SizedBox(width: 4),
        Expanded(
          child: Text(text, style: TextStyle(color: Colors.red, fontSize: 12)),
        ),
      ],
    );
  }
}
