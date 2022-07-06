import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:flutter/material.dart';

abstract class BoringFieldRequired<T> extends BoringField<T> {
  const BoringFieldRequired({
    Key? key,
    required String jsonKey,
    required String label,
    String? helperText,
    T? initialValue,
    BoringFieldController<T>? controller,
    this.required,
    required xs,
    required sm,
    required md,
    required lg,
  }) : super(
          jsonKey: jsonKey,
          label: label,
          helperText: helperText,
          initialValue: initialValue,
          controller: controller,
          key: key,
          xs: xs,
          sm: sm,
          md: md,
          lg: lg,
        );

  final String? required;
}
