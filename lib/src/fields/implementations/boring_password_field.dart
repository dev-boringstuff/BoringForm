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

  final TextEditingController textController = TextEditingController();

  @override
  String get value => textController.text;

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringPasswordField> createState() =>
      _BoringTextFieldState();

  @override
  set setValue(String value) {
    textController.text = value;
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringPasswordField> {
  String? errorText;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
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
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  void reset() {
    widget.textController.text = widget.initialValue ?? '';
  }
}
