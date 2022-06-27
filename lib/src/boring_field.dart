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
  }) : super(key: key);

  final T? initialValue;
  final String jsonKey;
  final String label;
  final String? helperText;
  final BoringFieldController<T>? controller;

  BoringField<T> copyWithController();
}

abstract class BoringFieldState<T> {
  void reset();
  void updateValid();
  void validate();
}
