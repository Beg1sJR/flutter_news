part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

final class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

final class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

final class NewsLoaded extends NewsState {
  final NewsModel newsDetails;
  final bool hasMore;
  final int currentPage;

  const NewsLoaded({
    required this.newsDetails,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [newsDetails, hasMore, currentPage];
}

final class NewsError extends NewsState {
  final String error;

  const NewsError({required this.error});

  @override
  List<Object?> get props => [error];
}
