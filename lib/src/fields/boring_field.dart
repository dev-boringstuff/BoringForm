import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:flutter/material.dart';

abstract class BoringField<T> extends StatefulWidget {
  const BoringField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.onChanged,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  }) : super(key: key);

  final T? initialValue;
  final String jsonKey;
  final String label;
  final String? helperText;
  final BoringFieldController<T>? controller;
  final void Function(T)? onChanged;
  final int xs;
  final int sm;
  final int md;
  final int lg;

  BoringField<T> copyWith();
}

abstract class BoringFieldState<T> {
  void reset();
}

abstract class BoringFieldStateWithValidation<T> extends BoringFieldState<T> {
  void updateValid();
  void validate();
}
