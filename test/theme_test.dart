import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:u_do/helpers/theme.dart';

void main() {
  group('Test ThemeNotifier', () {
    ThemeNotifier themeNotifier;

    setUp(() {
      themeNotifier = ThemeNotifier(CustomTheme.darkTheme);
    });

    test('Test setTheme', () {
      themeNotifier.setTheme(CustomTheme.lightTheme);
      expect(themeNotifier.getTheme(), CustomTheme.lightTheme);

      themeNotifier.setTheme(CustomTheme.darkTheme);
      expect(themeNotifier.getTheme(), CustomTheme.darkTheme);
    });

    testWidgets('Test that theme changes', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => themeNotifier,
          child: Builder(builder: (BuildContext context) {
            final appThemeNotifier = Provider.of<ThemeNotifier>(context);
            return MaterialApp(
                theme: appThemeNotifier.getTheme(),
                debugShowCheckedModeBanner: false,
                home: Container());
          })));

      await tester.pump();

      final context = tester.element(find.byType(Container));

      expect(Theme.of(context).brightness, CustomTheme.darkTheme.brightness);

      Provider.of<ThemeNotifier>(context, listen: false)
          .setTheme(CustomTheme.lightTheme);

      await tester.pumpAndSettle();

      expect(Theme.of(context).brightness, CustomTheme.lightTheme.brightness);
    });
  });

  group('Test CustomTheme', () {
    test('Test mapTheme', () {
      expect(CustomTheme.mapTheme(ThemeEnum.darkTheme), CustomTheme.darkTheme);
      expect(
          CustomTheme.mapTheme(ThemeEnum.lightTheme), CustomTheme.lightTheme);
    });

    test('Test mapTheme type checking', () {
      CustomTheme.mapTheme(ThemeEnum.darkTheme);
      CustomTheme.mapTheme(0);

      expect(() {
        CustomTheme.mapTheme('This should not work');
      }, throwsA(isA<AssertionError>()));
      expect(() {
        CustomTheme.mapTheme(CustomTheme.darkTheme);
      }, throwsA(isA<AssertionError>()));
    });
  });
}
