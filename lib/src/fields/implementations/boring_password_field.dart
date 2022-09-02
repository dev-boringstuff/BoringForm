import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringPasswordField extends BoringField<String> {
  BoringPasswordField({
    super.initialValue = '',
    super.onChanged,
    super.validator,
    required super.controller,
    super.title,
    super.helperText,
    required super.jsonKey,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  @override
  String get value => supportValue.value ?? '';

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringPasswordField, String> createState() =>
      _BoringTextFieldState();

  @override
  set setValue(String value) {
    controller.setValue(value);
  }

  final BoringSupportValue<String> supportValue = BoringSupportValue();
}

class _BoringTextFieldState
    extends BoringFieldState<BoringPasswordField, String> {
  String? errorText;
  bool obscureText = true;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
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
        suffixIcon: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Center(
              widthFactor: 0,
              child: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
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
