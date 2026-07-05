import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tiny Cubit that just tracks whether the app is in light or dark mode.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
