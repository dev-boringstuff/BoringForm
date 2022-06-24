import 'package:boring_form_builder/src/boring_field.dart';
import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:flutter/material.dart';

abstract class BoringFieldWithValidation<T> extends BoringField<T> {
  const BoringFieldWithValidation({
    Key? key,
    required String jsonKey,
    required String label,
    String? helperText,
    T? initialValue,
    BoringFieldController<T>? controller,
    this.validator,
  }) : super(
          jsonKey: jsonKey,
          label: label,
          helperText: helperText,
          initialValue: initialValue,
          controller: controller,
          key: key,
        );

  final String? Function(String?)? validator;
}
