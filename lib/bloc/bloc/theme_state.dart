part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  ThemeState([List theme = const [ThemeMode.system]]);
}

class ThemeInitial extends ThemeState {
  final ThemeMode theme;

  ThemeInitial(this.theme) : super([theme]);
  String toString() => 'ThemeInitial {theme: $theme}';
}

class HasTheme extends ThemeState {
  final ThemeMode theme;

  HasTheme(this.theme) : super([theme]);

  @override
  String toString() => "HasTheme { theme: $theme}";
}
