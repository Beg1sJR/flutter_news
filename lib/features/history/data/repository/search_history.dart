import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/features/history/domain/entity/search_history.dart';
import 'package:news/features/history/domain/repository/search_history.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  SearchHistoryRepositoryImpl(this.firestore, this.firebaseAuth);

  CollectionReference? get _historyRef {
    final userId = firebaseAuth.currentUser?.uid;
    log('userId: $userId');

    return firestore
        .collection('users')
        .doc(userId)
        .collection('search_history');
  }

  @override
  Future<void> addQuery(String keyword) async {
    await _historyRef!.add({'keyword': keyword, 'timestamp': Timestamp.now()});
  }

  @override
  Future<void> deleteQuery(String id) async {
    await _historyRef!.doc(id).delete();
  }

  @override
  Stream<List<SearchHistoryEntity>> watchHistory() {
    return _historyRef!
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => SearchHistoryEntity.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<List<SearchHistoryEntity>> loadHistory() async {
    final snapshot = await _historyRef!
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map(
          (doc) => SearchHistoryEntity.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();
  }

  @override
  Future<void> clearHistory() async {
    final batch = firestore.batch();
    final querySnapshot = await _historyRef!.get();
    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
