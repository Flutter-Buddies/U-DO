import 'package:flutter_test/flutter_test.dart';

import 'package:u_do/models/theme.dart';

void main() {
  group('Test ThemeNotifier', () {
    ThemeNotifier themeNotfier;

    setUp(() {
      themeNotfier = ThemeNotifier(CustomTheme.darkTheme);
    });

    test('Test setTheme', () {
      themeNotfier.setTheme(CustomTheme.lightTheme);
      expect(themeNotfier.getTheme(), CustomTheme.lightTheme);

      themeNotfier.setTheme(CustomTheme.darkTheme);
      expect(themeNotfier.getTheme(), CustomTheme.darkTheme);
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
