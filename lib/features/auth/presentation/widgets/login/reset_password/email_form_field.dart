import 'package:flutter/material.dart';
import 'package:news/features/auth/presentation/widgets/login/reset_password/widgets.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required this.isEmailError,
    required this.emailController,
    required this.errorMessage,
    this.validator,
  });

  final TextEditingController emailController;
  final bool isEmailError;
  final String errorMessage;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email поле
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validator,
            decoration: InputDecoration(
              labelText: 'Email адрес',
              labelStyle: TextStyle(
                color: isEmailError ? Colors.red : Color(0xFF3498DB),
              ),
              prefixIcon: Container(
                margin: EdgeInsets.only(left: 12, right: 8),
                child: Icon(
                  Icons.email_outlined,
                  color: isEmailError ? Colors.red : Color(0xFF3498DB),
                  size: 20,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isEmailError ? Colors.red : Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isEmailError ? Colors.red : Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isEmailError ? Colors.red : Color(0xFF3498DB),
                ),
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          if (isEmailError && errorMessage.isNotEmpty) ...[
            SizedBox(height: 8),
            BuildErrorText(text: errorMessage),
          ],
        ],
      ),
    );
  }
}
