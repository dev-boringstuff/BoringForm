import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringCheckbox extends BoringField<bool> {
  BoringCheckbox({
    super.initialValue,
    required super.controller,
    super.title,
    super.helperText,
    required super.jsonKey,
    super.onChanged,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  @override
  bool? get value => supportValue.value;

  @override
  bool get isValid => this.required ? controller.getValue() != null : true;
  @override
  BoringFieldState<BoringCheckbox> createState() => _BoringCheckboxState();

  @override
  set setValue(bool? value) {
    supportValue.value = value;
  }

  final BoringSupportValue<bool> supportValue = BoringSupportValue();
}

class _BoringCheckboxState extends BoringFieldState<BoringCheckbox> {
  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: widget.controller.getValue() ?? false,
      title: Text(widget.title ?? ''),
      subtitle: widget.helperText != null ? Text(widget.helperText!) : null,
      onChanged: (newValue) {
        setState(() {
          widget.setValue = newValue;
        });
        widget.onChanged?.call(newValue);
      },
    );
  }

  @override
  void validate() {}

  @override
  void reset() {
    setState(() {
      widget.setValue = widget.initialValue;
    });
  }
}
