import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/bloc/cubit/settings_cubit.dart';
import 'package:news/core/theme/theme.dart';
import 'package:news/features/profile/presentation/widgets/settings/widgets.dart';
import 'package:news/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  final List<Map<String, String>> _languages = [
    {'code': 'ru', 'name': 'Русский'},
    {'code': 'en', 'name': 'English'},
    {'code': 'kk', 'name': 'Қазақша'},
  ];

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final currentLangCode = context.watch<SettingsCubit>().state.language;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            S.of(context).chooseLanguage,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _languages.map((language) {
              return RadioListTile<String>(
                title: Text(language['name']!),
                value: language['code']!,
                groupValue: currentLangCode,
                activeColor: Color(0xFF3498DB),
                onChanged: (String? value) {
                  if (value != null) {
                    context.read<SettingsCubit>().setLanguage(value);
                  }
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String getLanguageName(String code) => _languages.firstWhere(
    (lang) => lang['code'] == code,
    orElse: () => {'name': code},
  )['name']!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    final language = context.watch<SettingsCubit>().state.language;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).settings,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        S.of(context).appearance,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //Dark Theme
                    SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      iconColor: Colors.purple,
                      title: S.of(context).darkTheme,
                      subtitle: brightness == Brightness.dark
                          ? S.of(context).turnedOn
                          : S.of(context).turnedOff,
                      trailing: theme.isAndroid
                          ? Switch(
                              value: brightness == Brightness.dark,
                              activeColor: Color(0xFF3498DB),
                              onChanged: (bool value) {
                                context.read<SettingsCubit>().setTheme(
                                  value ? Brightness.dark : Brightness.light,
                                );
                              },
                            )
                          : CupertinoSwitch(
                              value: brightness == Brightness.dark,
                              onChanged: (bool value) {
                                context.read<SettingsCubit>().setTheme(
                                  value ? Brightness.dark : Brightness.light,
                                );
                              },
                            ),
                    ),

                    Divider(height: 1, indent: 16, endIndent: 16),
                    //Language
                    SettingsTile(
                      icon: Icons.language_outlined,
                      iconColor: Colors.blue,
                      title: S.of(context).language,
                      subtitle: getLanguageName(language),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      onTap: _showLanguageDialog,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        S.of(context).notifications,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Push Notifications
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      iconColor: Colors.orange,
                      title: S.of(context).pushNotifications,
                      subtitle: _notificationsEnabled
                          ? S.of(context).turnedOn
                          : S.of(context).turnedOff,
                      trailing: theme.isAndroid
                          ? Switch(
                              value: _notificationsEnabled,
                              activeColor: Color(0xFF3498DB),
                              onChanged: (bool value) {
                                setState(() {
                                  _notificationsEnabled = value;
                                });
                              },
                            )
                          : CupertinoSwitch(
                              value: _notificationsEnabled,
                              onChanged: (bool value) {
                                setState(() {
                                  _notificationsEnabled = value;
                                });
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
