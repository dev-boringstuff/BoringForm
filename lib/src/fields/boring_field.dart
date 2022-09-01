import 'package:boring_form_builder/src/boring_controller.dart';
import 'package:flutter/material.dart';

abstract class BoringField<T> extends StatefulWidget {
  BoringField(
      {Key? key,
      required this.controller,
      this.initialValue,
      required this.jsonKey,
      this.title,
      this.helperText,
      this.onChanged,
      this.required = false,
      this.lg = 12,
      this.md = 12,
      this.sm = 12,
      this.xs = 12,
      this.validator})
      : super(key: key) {
    controller.getValue = () => value;
    controller.isValid = () => isValid;
  }

  final int xs, sm, md, lg;

  final BoringController controller;
  final void Function(T?)? onChanged;

  bool get isValid;
  T? get value;
  set setValue(T value);
  final String jsonKey;

  final T? initialValue;
  final String? title;
  final String? helperText;
  final String? Function(T?)? validator;
  final bool required;
}
