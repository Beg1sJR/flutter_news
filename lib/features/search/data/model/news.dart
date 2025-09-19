// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news/features/search/data/model/model.dart';

class SearchNewsModel extends Equatable {
  final String? status;
  final int? totalResutls;
  final List<ArticlesModel>? articles;
  const SearchNewsModel({this.status, this.totalResutls, this.articles});

  SearchNewsModel copyWith({
    String? status,
    int? totalResutls,
    List<ArticlesModel>? articles,
  }) {
    return SearchNewsModel(
      status: status ?? this.status,
      totalResutls: totalResutls ?? this.totalResutls,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResutls': totalResutls,
      'articles': articles?.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchNewsModel.fromMap(Map<String, dynamic> map) {
    return SearchNewsModel(
      status: map['status'] != null ? map['status'] as String : null,
      totalResutls: map['totalResutls'] != null
          ? map['totalResutls'] as int
          : null,
      articles: map['articles'] != null
          ? List<ArticlesModel>.from(
              (map['articles'] as List<dynamic>).map<ArticlesModel?>(
                (x) => ArticlesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchNewsModel.fromJson(String source) =>
      SearchNewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResutls, articles];
}
