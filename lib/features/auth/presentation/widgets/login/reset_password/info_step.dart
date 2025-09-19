import 'package:flutter/material.dart';
import 'package:news/features/auth/presentation/widgets/login/reset_password/widgets.dart';

class InfoStep extends StatelessWidget {
  const InfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF3498DB).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF3498DB), size: 20),
              SizedBox(width: 8),
              Text(
                'Что происходит дальше?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          BuildInfoStep(
            number: '1',
            text: 'Мы отправим письмо на указанный email',
          ),
          BuildInfoStep(number: '2', text: 'Перейдите по ссылке в письме'),
          BuildInfoStep(number: '3', text: 'Создайте новый пароль в браузере'),
          BuildInfoStep(
            number: '4',
            text: 'Войдите в приложение с новым паролем',
          ),
        ],
      ),
    );
  }
}
