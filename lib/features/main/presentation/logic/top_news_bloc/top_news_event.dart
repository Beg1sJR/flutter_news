part of 'top_news_bloc.dart';

sealed class TopNewsEvent extends Equatable {
  const TopNewsEvent();

  @override
  List<Object> get props => [];
}

class LoadTopNews extends TopNewsEvent {
  @override
  List<Object> get props => [];
}
