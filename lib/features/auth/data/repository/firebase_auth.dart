import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news/features/auth/domain/entity/app_user.dart';
import 'package:news/features/auth/domain/repository/firebase_auth.dart';

class FirebaseAuthImpl implements FirebaseAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseAuthImpl(this._firebaseAuth, this._firestore, this._storage);

  @override
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName(username);

      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.reload();
      return _firebaseAuth.currentUser;
    }
    return null;
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Stream<AppUserEntity?> watchUserData(String userId) {
    final docRef = _firestore.collection('users').doc(userId);

    return docRef.snapshots().map((docSnapshot) {
      return AppUserEntity.fromFirestore(docSnapshot);
    });
  }

  @override
  Future<void> updateUserData(Map<String, dynamic> data) async {
    final userId = _firebaseAuth.currentUser?.uid;

    await _firestore.collection('users').doc(userId).update(data);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String> uploadAndSaveAvatar({required File imageFile}) async {
    final userId = _firebaseAuth.currentUser?.uid;

    final storageRef = _storage.ref().child('avatars').child('$userId.jpg');
    await storageRef.putFile(imageFile);
    final downloadUrl = await storageRef.getDownloadURL();
    log('Avatar uploaded to storage: $downloadUrl');

    await _firestore.collection('users').doc(userId).update({
      'avatarUrl': downloadUrl,
    });
    log('Avatar uploaded and URL saved: $downloadUrl');

    return downloadUrl;
  }
}
