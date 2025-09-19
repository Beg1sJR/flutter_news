import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUserEntity extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;

  const AppUserEntity({
    required this.uid,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
  });

  AppUserEntity copyWith({
    String? uid,
    String? username,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return AppUserEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory AppUserEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return AppUserEntity(
      uid: doc.id,
      avatarUrl: data?['avatarUrl'],
      username: data?['username'] ?? '',
      email: data?['email'] ?? '',
      phoneNumber: data?['phoneNumber'],
    );
  }

  @override
  List<Object?> get props => [uid, username, email, phoneNumber, avatarUrl];
}
