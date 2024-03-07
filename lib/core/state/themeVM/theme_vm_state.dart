import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_vm_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  factory ThemeState({required ThemeMode themeMode}) = _ThemeState;
}
