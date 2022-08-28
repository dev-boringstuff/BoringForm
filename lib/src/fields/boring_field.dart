import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/widgets.dart';

abstract class BoringField<T> extends StatefulWidget {
  BoringField(
      {Key? key,
      required this.boringFieldController,
      this.initialValue,
      required this.jsonKey,
      this.label,
      this.helperText,
      this.validator})
      : super(key: key) {
    boringFieldController.getValue = () => value;
    boringFieldController.reset = reset;
    boringFieldController.isValid = () => isValid;
  }
  final BoringFieldController boringFieldController;
  void onChanged(T value);
  void reset();

  bool get isValid;
  T get value;
  final String jsonKey;

  final T? initialValue;
  final String? label;
  final String? helperText;
  final String? Function(String)? validator;
}
