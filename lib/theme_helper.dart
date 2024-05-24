import 'package:flutter/material.dart';

extension ThemeHelper on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextStyle? get emphasis => theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );
}
