import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringTexField extends BoringField<String> {
  BoringTexField({
    super.initialValue = '',
    this.onValueChanged,
    this.validator,
    required super.controller,
    super.title,
    required super.jsonKey,
    super.key,
  });

  final TextEditingController textController = TextEditingController();
  @override
  final String? Function(String)? validator;
  final void Function(String)? onValueChanged;

  @override
  String get value => textController.text;

  @override
  void onChanged(String value) {
    onValueChanged?.call(value);
  }

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringTexField> createState() => _BoringTextFieldState();

  @override
  set setValue(String value) {
    textController.text = value;
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringTexField> {
  String? errorText;

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(errorText: errorText),
      controller: widget.textController,
      onChanged: (value) => widget.onChanged(value),
    );
  }

  @override
  void reset() {
    widget.textController.text = widget.initialValue ?? '';
  }
}
