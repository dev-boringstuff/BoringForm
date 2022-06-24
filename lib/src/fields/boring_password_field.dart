import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_text_field.dart';
import 'package:flutter/material.dart';

class BoringPasswordField extends BoringTextField {
  const BoringPasswordField({
    Key? key,
    required String jsonKey,
    required String label,
    String? helperText,
    String? initialValue,
    BoringFieldController<String>? controller,
  }) : super(
          key: key,
          jsonKey: jsonKey,
          label: label,
          helperText: helperText,
          initialValue: initialValue,
          controller: controller,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        );
}
