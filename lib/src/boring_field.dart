import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:flutter/material.dart';

abstract class BoringField<T> extends StatefulWidget {
  const BoringField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
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
  final int xs;
  final int sm;
  final int md;
  final int lg;

  BoringField<T> copyWithController();
}

abstract class BoringFieldState<T> {
  void reset();
  void updateValid();
  void validate();
}
