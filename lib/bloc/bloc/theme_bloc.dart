import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(ThemeMode.system));
  ThemeMode _theme = ThemeMode.system;

  get theme => _theme;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is HasTheme) {
      yield HasTheme(_theme);
    } else if (event is SetTheme) {
      this._handleSetTheme(event.theme);
      yield HasTheme(_theme);
    }
  }

  void _handleSetTheme(theme) => _theme = theme;
}
