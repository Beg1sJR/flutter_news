import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatelessWidget {
  PhoneTextField({super.key, required this.phoneController});

  final phoneMaskFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: [phoneMaskFormatter],
      decoration: InputDecoration(
        prefixText: '+7 ',
        labelText: 'Номер телефона',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3498DB)),
        ),
        filled: true,
        fillColor: theme.cardColor,
      ),
    );
  }
}
