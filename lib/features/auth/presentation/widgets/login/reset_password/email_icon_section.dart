import 'package:flutter/material.dart';

class EmailIconSection extends StatelessWidget {
  const EmailIconSection({super.key, required this.isEmailSent});

  final bool isEmailSent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
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
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isEmailSent
                  ? Colors.green.withOpacity(0.1)
                  : Color(0xFF3498DB).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEmailSent ? Icons.mark_email_read : Icons.email_outlined,
              color: isEmailSent ? Colors.green : Color(0xFF3498DB),
              size: 40,
            ),
          ),
          SizedBox(height: 16),
          Text(
            isEmailSent ? 'Письмо отправлено!' : 'Забыли пароль?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            isEmailSent
                ? 'Мы отправили инструкции для сброса пароля на вашу почту. Проверьте входящие сообщения и следуйте инструкциям.'
                : 'Введите ваш email адрес и мы отправим вам ссылку для сброса пароля',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
