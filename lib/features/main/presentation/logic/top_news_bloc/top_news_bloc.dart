import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/features/main/data/model/model.dart';
import 'package:news/features/main/domain/repository/top_news.dart';

part 'top_news_event.dart';
part 'top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  final TopNewsRepository topNewsRepository;

  TopNewsBloc(this.topNewsRepository) : super(TopNewsInitial()) {
    on<LoadTopNews>((event, emit) async {
      emit(TopNewsLoading());
      try {
        final topNewsDetails = await topNewsRepository.getTopNews();
        emit(TopNewsLoaded(topNewsDetails));
      } catch (e) {
        emit(TopNewsError(error: e.toString()));
      }
    });
  }
}
