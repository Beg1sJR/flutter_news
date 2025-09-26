import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/auth/domain/entity/app_user.dart';

void main() {
  // Юнит-тест: Проверка copyWith для AppUserEntity
  test('AppUserEntity copyWith returns updated values', () {
    final user = AppUserEntity(
      uid: '1',
      username: 'user',
      email: 'test@mail.com',
    );
    final updated = user.copyWith(username: 'newuser');
    expect(updated.username, 'newuser');
    expect(updated.uid, '1');
    expect(updated.email, 'test@mail.com');
  });
}
