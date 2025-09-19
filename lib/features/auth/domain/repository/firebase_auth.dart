import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/features/auth/domain/entity/app_user.dart';

abstract interface class FirebaseAuthRepository {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  });

  Stream<AppUserEntity?> watchUserData(String userId);
  Future<void> updateUserData(Map<String, dynamic> data);
  Future<void> sendPasswordResetEmail(String email);
  Future<String> uploadAndSaveAvatar({required File imageFile});
}
