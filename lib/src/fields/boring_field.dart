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
      this.lg = 12,
      this.md = 12,
      this.sm = 12,
      this.xs = 12,
      this.validator})
      : super(key: key) {
    boringFieldController.getValue = () => value;
    boringFieldController.isValid = () => isValid;
  }

  final int xs, sm, md, lg;

  final BoringFieldController boringFieldController;
  void onChanged(T value);

  bool get isValid;
  T get value;
  set setValue(T value);
  final String jsonKey;

  final T? initialValue;
  final String? label;
  final String? helperText;
  final String? Function(String)? validator;
}
