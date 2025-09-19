part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {
  @override
  List<Object> get props => [];
}

class LoadMoreNews extends NewsEvent {
  @override
  List<Object> get props => [];
}
