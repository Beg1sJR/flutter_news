import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/profile/presentation/widgets/profile/profile_tile.dart';

void main() {
  // Виджет-тест: ProfileTile отображает корректные данные
  testWidgets('ProfileTile displays correct title and icon', (
    WidgetTester tester,
  ) async {
    const testTitle = 'Test Title';
    const testIcon = Icons.person;
    const testColor = Colors.blue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTile(icon: testIcon, title: testTitle, color: testColor),
        ),
      ),
    );

    expect(find.text(testTitle), findsOneWidget);
    expect(find.byIcon(testIcon), findsOneWidget);
  });

  // Виджет-тест: ProfileTile вызывает onTap
  testWidgets('ProfileTile calls onTap when tapped', (
    WidgetTester tester,
  ) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTile(
            icon: Icons.person,
            title: 'Tap me',
            color: Colors.blue,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ProfileTile));
    expect(tapped, isTrue);
  });
}
