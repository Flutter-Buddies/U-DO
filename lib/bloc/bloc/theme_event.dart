part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeMode theme;
  SetTheme(this.theme);
}
