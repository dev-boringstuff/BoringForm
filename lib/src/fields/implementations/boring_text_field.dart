import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringTextField extends BoringField<String> {
  BoringTextField({
    super.initialValue = '',
    super.validator,
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

  @override
  String get value => supportValue.value ?? '';

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringTextField, String> createState() =>
      _BoringTextFieldState();

  final BoringSupportValue<String> supportValue = BoringSupportValue();

  @override
  set setValue(String value) {
    controller.setValue(value);
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringTextField, String> {
  final TextEditingController textController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
        widget.supportValue.value = value;
        widget.onChanged?.call(value);
      },
      decoration: InputDecoration(
        label: Text(widget.title ?? ''),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void setValue(String? newValue) {
    widget.supportValue.value = newValue;
    textController.text = newValue ?? '';
  }

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  void reset() {
    textController.text = widget.initialValue ?? '';
  }
}
