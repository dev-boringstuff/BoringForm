import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringTextField extends BoringField<String> {
  BoringTextField({
    super.initialValue = '',
    this.validator,
    required super.controller,
    super.title,
    super.helperText,
    required super.jsonKey,
    this.enableSuggestions = false,
    this.autocorrect = false,
    super.onChanged,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  final bool enableSuggestions;
  final bool autocorrect;
  final TextEditingController textController = TextEditingController();
  @override
  final String? Function(String)? validator;

  @override
  String get value => textController.text;

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringTextField> createState() => _BoringTextFieldState();

  @override
  set setValue(String value) {
    textController.text = value;
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringTextField> {
  String? errorText;

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      onChanged: (value) => widget.onChanged?.call(value),
      decoration: InputDecoration(
        label: Text(widget.title ?? ''),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void reset() {
    widget.textController.text = widget.initialValue ?? '';
  }
}
