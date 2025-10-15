import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news/core/bloc/cubit/settings_cubit.dart';
import 'package:news/generated/l10n.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark
                    ? Colors.grey.shade900.withOpacity(0.7)
                    : Colors.white.withOpacity(0.8),
                border: Border.all(
                  color: Colors.white.withOpacity(isDark ? 0.05 : 0.2),
                  width: 1.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GNav(
                  selectedIndex: navigationShell.currentIndex,
                  gap: 8,
                  padding: const EdgeInsets.all(15),
                  color: isDark ? Colors.white70 : Colors.black54,
                  activeColor: Colors.deepPurpleAccent,
                  tabBackgroundColor: theme.colorScheme.primary.withOpacity(
                    0.08,
                  ),
                  backgroundColor: Colors.transparent,
                  onTabChange: (index) => _onTap(context, index),
                  tabs: [
                    GButton(icon: Icons.home, text: S.of(context).main),
                    GButton(icon: Icons.search, text: S.of(context).search),
                    GButton(icon: Icons.history, text: S.of(context).history),
                    GButton(icon: Icons.person, text: S.of(context).profile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index != navigationShell.currentIndex,
    );
  }
}
