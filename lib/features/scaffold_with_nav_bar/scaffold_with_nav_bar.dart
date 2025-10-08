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
    // final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    bool isDark = brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GNav(
          selectedIndex: navigationShell.currentIndex,
          tabBorderRadius: 30,
          tabActiveBorder: Border.all(
            color: isDark ? Colors.grey.shade600 : Colors.black,
            width: 1,
          ),
          padding: const EdgeInsets.all(12),
          // tabBackgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          onTabChange: (int index) => _onTap(context, index),
          gap: 8,
          tabs: [
            GButton(icon: Icons.home, text: S.of(context).main),
            GButton(icon: Icons.search, text: S.of(context).search),
            GButton(icon: Icons.history, text: S.of(context).history),
            GButton(icon: Icons.person, text: S.of(context).profile),
          ],
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


// body: navigationShell,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: navigationShell.currentIndex,
//         onTap: (int index) => _onTap(context, index),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: theme.colorScheme.primary,
//         unselectedItemColor: theme.hintColor,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: S.of(context).main,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: S.of(context).search,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: S.of(context).history,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: S.of(context).profile,
//           ),
//         ],
//       ),