import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:u_do/helpers/theme.dart';

void main() {
  group('Test ThemeNotifier', () {
    ThemeModeNotifier themeNotifier;

    setUp(() {
      themeNotifier = ThemeModeNotifier(ThemeMode.system);
    });

    test('Test setTheme', () {
      themeNotifier.setThemeMode(ThemeMode.light);
      expect(themeNotifier.getThemeMode(), ThemeMode.light);

      themeNotifier.setThemeMode(ThemeMode.dark);
      expect(themeNotifier.getThemeMode(), ThemeMode.dark);
    });

    testWidgets('Test that theme changes', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider<ThemeModeNotifier>(
          create: (context) => themeNotifier,
          child: Builder(builder: (BuildContext context) {
            final appThemeNotifier = Provider.of<ThemeModeNotifier>(context);
            return MaterialApp(
                themeMode: appThemeNotifier.getThemeMode(),
                darkTheme: CustomTheme.darkTheme,
                theme: CustomTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                home: Container());
          })));

      await tester.pump();

      final context = tester.element(find.byType(Container));

      // Text theming seems to change based on localization
      // Checking that the brightness changes should be sufficient for now.
      expect(Theme.of(context).brightness, CustomTheme.lightTheme.brightness);

      Provider.of<ThemeModeNotifier>(context, listen: false)
          .setThemeMode(ThemeMode.dark);

      await tester.pumpAndSettle();

      expect(Theme.of(context).brightness, CustomTheme.darkTheme.brightness);
    });
  });

  group('Test CustomTheme', () {
    test('Test mapTheme', () {
      expect(CustomTheme.mapThemeMode('dark'), ThemeMode.dark);
      expect(CustomTheme.mapThemeMode('light'), ThemeMode.light);
      expect(CustomTheme.mapThemeMode('system'), ThemeMode.system);
    });

    test('Test mapTheme string checking', () {
      expect(() {
        CustomTheme.mapThemeMode(null);
      }, throwsA(isA<AssertionError>()));

      expect(() {
        CustomTheme.mapThemeMode('This should not work');
      }, throwsA(isA<AssertionError>()));
    });
  });
}
