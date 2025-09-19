// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get main {
    return Intl.message('Home', name: 'main', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `News feed`
  String get newsFeed {
    return Intl.message('News feed', name: 'newsFeed', desc: '', args: []);
  }

  /// `Latest news`
  String get lastNews {
    return Intl.message('Latest news', name: 'lastNews', desc: '', args: []);
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Searching news...`
  String get searchNews {
    return Intl.message(
      'Searching news...',
      name: 'searchNews',
      desc: '',
      args: [],
    );
  }

  /// `Enter a query to search for news`
  String get enterWordToSearchNews {
    return Intl.message(
      'Enter a query to search for news',
      name: 'enterWordToSearchNews',
      desc: '',
      args: [],
    );
  }

  /// `Search history`
  String get historyOfSearch {
    return Intl.message(
      'Search history',
      name: 'historyOfSearch',
      desc: '',
      args: [],
    );
  }

  /// `Clear history`
  String get clearHistory {
    return Intl.message(
      'Clear history',
      name: 'clearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear your entire search history?`
  String get youSureYouWantClearHistory {
    return Intl.message(
      'Are you sure you want to clear your entire search history?',
      name: 'youSureYouWantClearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Search history is empty`
  String get searchHistoryIsEmpty {
    return Intl.message(
      'Search history is empty',
      name: 'searchHistoryIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Your search queries will be displayed here`
  String get hereWillDisplayYourSearchWords {
    return Intl.message(
      'Your search queries will be displayed here',
      name: 'hereWillDisplayYourSearchWords',
      desc: '',
      args: [],
    );
  }

  /// `results`
  String get results {
    return Intl.message('results', name: 'results', desc: '', args: []);
  }

  /// `My details`
  String get myDetails {
    return Intl.message('My details', name: 'myDetails', desc: '', args: []);
  }

  /// `Write to support`
  String get textToSupport {
    return Intl.message(
      'Write to support',
      name: 'textToSupport',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Log out of account`
  String get logOut {
    return Intl.message(
      'Log out of account',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Change photo`
  String get changePhoto {
    return Intl.message(
      'Change photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInfromation {
    return Intl.message(
      'Personal information',
      name: 'personalInfromation',
      desc: '',
      args: [],
    );
  }

  /// `No name`
  String get noName {
    return Intl.message('No name', name: 'noName', desc: '', args: []);
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `No changes to save`
  String get noChangesToSave {
    return Intl.message(
      'No changes to save',
      name: 'noChangesToSave',
      desc: '',
      args: [],
    );
  }

  /// `Details successfully updated`
  String get detailsSuccessfullyUpdated {
    return Intl.message(
      'Details successfully updated',
      name: 'detailsSuccessfullyUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveUpdates {
    return Intl.message(
      'Save changes',
      name: 'saveUpdates',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. All your data will be permanently deleted.`
  String get thisActionCantBeUndoneAllYourDataWillPermanentlyDeleted {
    return Intl.message(
      'This action cannot be undone. All your data will be permanently deleted.',
      name: 'thisActionCantBeUndoneAllYourDataWillPermanentlyDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Choose language`
  String get chooseLanguage {
    return Intl.message(
      'Choose language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message('Dark theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `Turned on`
  String get turnedOn {
    return Intl.message('Turned on', name: 'turnedOn', desc: '', args: []);
  }

  /// `Turned off`
  String get turnedOff {
    return Intl.message('Turned off', name: 'turnedOff', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Push notifications`
  String get pushNotifications {
    return Intl.message(
      'Push notifications',
      name: 'pushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message('Log in', name: 'login', desc: '', args: []);
  }

  /// `Clean`
  String get clean {
    return Intl.message('Clean', name: 'clean', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
