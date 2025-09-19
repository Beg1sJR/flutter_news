part of 'top_news_bloc.dart';

sealed class TopNewsState extends Equatable {
  const TopNewsState();

  @override
  List<Object> get props => [];
}

final class TopNewsInitial extends TopNewsState {
  @override
  List<Object> get props => [];
}

final class TopNewsLoading extends TopNewsState {
  @override
  List<Object> get props => [];
}

final class TopNewsLoaded extends TopNewsState {
  final NewsModel topNewsDetails;

  const TopNewsLoaded(this.topNewsDetails);
  @override
  List<Object> get props => [topNewsDetails];
}

final class TopNewsError extends TopNewsState {
  final String error;

  const TopNewsError({required this.error});
  @override
  List<Object> get props => [error];
}
