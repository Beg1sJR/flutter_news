import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news/core/bloc/cubit/settings_cubit.dart';
import 'package:news/core/router/router.dart';
import 'package:news/core/theme/theme.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/history/presentation/logic/search_history_bloc/search_history_bloc.dart';
import 'package:news/features/main/presentation/logic/news_bloc/news_bloc.dart';
import 'package:news/features/main/presentation/logic/top_news_bloc/top_news_bloc.dart';
import 'package:news/features/search/presentation/logic/search_news_bloc/search_news_bloc.dart';
import 'package:news/firebase_options.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/injection.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeFirebaseMessaging();
  await dotenv.load();

  await setupLocator();

  runApp(const MyApp());
}

Future<void> initializeFirebaseMessaging() async {
  try {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('Статус разрешений FCM: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      String? token = await messaging.getToken();
      if (token != null) {
        log('Firebase Messaging Token: $token');
      } else {
        log('FCM Token is null');
      }
    } else {
      log('FCM разрешения не предоставлены');
    }
  } catch (e) {
    log('Error with Firebase Messaging: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final talker = getIt<Talker>();
    final routeRepository = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        Provider<Talker>.value(value: talker),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<NewsBloc>()..add(LoadNews())),
        BlocProvider(
          create: (context) => getIt<TopNewsBloc>()..add(LoadTopNews()),
        ),
        BlocProvider(create: (context) => getIt<SearchNewsBloc>()),
        BlocProvider(create: (context) => getIt<SearchHistoryBloc>()),
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'News',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(state.language),
            supportedLocales: S.delegate.supportedLocales,
            theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
            routerConfig: routeRepository.router,
          );
        },
      ),
    );
  }
}
