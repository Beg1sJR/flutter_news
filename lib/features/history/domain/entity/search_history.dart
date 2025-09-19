import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SearchHistoryEntity extends Equatable {
  final String id; // Firestore document id
  final String keyword;
  final int? totalResults;
  final DateTime timestamp;

  const SearchHistoryEntity({
    required this.id,
    required this.keyword,
    this.totalResults,
    required this.timestamp,
  });

  SearchHistoryEntity copyWith({
    String? id,
    String? keyword,
    int? totalResults,
    DateTime? timestamp,
  }) {
    return SearchHistoryEntity(
      id: id ?? this.id,
      keyword: keyword ?? this.keyword,
      totalResults: totalResults ?? this.totalResults,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keyword': keyword,
      'totalResults': totalResults,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // Firestore: map from doc.data() and doc.id
  factory SearchHistoryEntity.fromMap(Map<String, dynamic> map, String id) {
    return SearchHistoryEntity(
      id: id,
      keyword: map['keyword'] as String? ?? '',
      totalResults: map['totalResults'] != null
          ? map['totalResults'] as int
          : null,
      timestamp: (map['timestamp'] is Timestamp)
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode({
    'keyword': keyword,
    'totalResults': totalResults,
    'timestamp': timestamp.toIso8601String(),
  });

  factory SearchHistoryEntity.fromJson(String source, String id) {
    final map = json.decode(source) as Map<String, dynamic>;
    return SearchHistoryEntity(
      id: id,
      keyword: map['keyword'] as String? ?? '',
      totalResults: map['totalResults'] != null
          ? map['totalResults'] as int
          : null,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  @override
  String toString() {
    return 'SearchHistoryEntity(id: $id, keyword: $keyword, totalResults: $totalResults, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant SearchHistoryEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.keyword == keyword &&
        other.totalResults == totalResults &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        keyword.hashCode ^
        totalResults.hashCode ^
        timestamp.hashCode;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, keyword, totalResults, timestamp];
}
