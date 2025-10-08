import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news/core/bloc/cubit/settings_cubit.dart';
import 'package:news/core/router/router.dart';
import 'package:news/features/auth/data/repository/firebase_auth.dart';
import 'package:news/features/auth/domain/repository/firebase_auth.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/history/data/repository/search_history.dart';
import 'package:news/features/history/domain/repository/search_history.dart';
import 'package:news/features/history/presentation/logic/search_history_bloc/search_history_bloc.dart';
import 'package:news/features/main/data/data_source/news.dart';
import 'package:news/features/main/data/data_source/top_news.dart';
import 'package:news/features/main/data/repository/news.dart';
import 'package:news/features/main/data/repository/top_news.dart';
import 'package:news/features/main/domain/repository/news.dart';
import 'package:news/features/main/domain/repository/top_news.dart';
import 'package:news/features/main/presentation/logic/news_bloc/news_bloc.dart';
import 'package:news/features/main/presentation/logic/top_news_bloc/top_news_bloc.dart';
import 'package:news/features/profile/data/repository/settings/settings.dart';
import 'package:news/features/profile/domain/repository/settings/settings.dart';
import 'package:news/features/search/data/data_source/search_news.dart';
import 'package:news/features/search/data/repository/search_news.dart';
import 'package:news/features/search/domain/repository/search_news.dart';
import 'package:news/features/search/presentation/logic/search_news_bloc/search_news_bloc.dart';
import 'package:news/services/notification/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final talker = TalkerFlutter.init();
  final dio = Dio();
  final sharedPreferences = await SharedPreferences.getInstance();

  talker.verbose('Talker initialized');
  getIt.registerSingleton<Talker>(talker);
  getIt.registerSingleton<Dio>(dio);

  Bloc.observer = TalkerBlocObserver(
    talker: getIt<Talker>(),
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
      printCreations: false,
      printClosings: false,
      printTransitions: false,
      printChanges: true,
    ),
  );
  log('bloc talker launched');

  dio.interceptors.add(
    TalkerDioLogger(
      talker: getIt<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printRequestData: false,
        printRequestHeaders: false,
        printResponseData: false,
        printResponseHeaders: false,
      ),
    ),
  );
  log('dio talker launched');

  //firebase auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //firebase storage
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //firebase firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  //services
  getIt.registerSingleton<NotificationService>(NotificationService());

  //router
  getIt.registerSingleton<AppRouter>(AppRouter());
  log('AppRouter registered');

  //shared preferences
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  log('shared preferences registered');

  //data source
  getIt.registerLazySingleton<NewsData>(() => NewsData(dio: getIt<Dio>()));
  log('news data registered');
  getIt.registerLazySingleton<TopNewsData>(
    () => TopNewsData(dio: getIt<Dio>()),
  );
  log('top news data registered');

  getIt.registerLazySingleton<SearchNewsData>(
    () => SearchNewsData(dio: getIt<Dio>()),
  );
  log('search news data registered');

  //repo
  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(newsData: getIt<NewsData>()),
  );
  log('news repo registered');

  getIt.registerLazySingleton<TopNewsRepository>(
    () => TopNewsRepositoryImpl(topNewsData: getIt<TopNewsData>()),
  );
  log('top news repo registered');

  getIt.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<FirebaseStorage>(),
    ),
  );
  log('firebase auth repo registered');

  getIt.registerLazySingleton<SearchNewsRepository>(
    () => SearchNewsRepositoryImpl(searchNewsData: getIt<SearchNewsData>()),
  );
  log('search news repo registered');

  getIt.registerLazySingleton<SearchHistoryRepository>(
    () => SearchHistoryRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseAuth>(),
    ),
  );
  log('search history repo registered');

  getIt.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(sharedPreferences: getIt<SharedPreferences>()),
  );
  log('settings repo registered');

  //bloc
  getIt.registerLazySingleton<NewsBloc>(
    () => NewsBloc(getIt<NewsRepository>()),
  );
  log('news bloc registered');

  getIt.registerLazySingleton<TopNewsBloc>(
    () => TopNewsBloc(getIt<TopNewsRepository>()),
  );
  log('top news bloc registered');

  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(getIt<FirebaseAuthRepository>()),
  );

  getIt.registerLazySingleton<SearchNewsBloc>(
    () => SearchNewsBloc(getIt<SearchNewsRepository>()),
  );
  log('search news bloc registered');

  getIt.registerLazySingleton<SearchHistoryBloc>(
    () =>
        SearchHistoryBloc(getIt<SearchHistoryRepository>(), getIt<AuthBloc>()),
  );
  log('search history bloc registered');

  //cubit

  getIt.registerSingleton<SettingsCubit>(
    SettingsCubit(getIt<SettingsRepository>()),
  );
  log('settings cubit registered');

  //services
}
