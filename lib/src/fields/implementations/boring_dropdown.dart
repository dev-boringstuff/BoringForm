import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringDropdown<T> extends BoringField<T> {
  BoringDropdown({
    super.initialValue,
    required super.controller,
    super.title,
    super.helperText,
    super.required,
    required super.jsonKey,
    super.onChanged,
    required this.items,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  @override
  T? get value => supportValue.value;

  @override
  bool get isValid => this.required ? controller.getValue() != null : true;
  @override
  BoringFieldState<BoringDropdown<T>> createState() => _BoringDropdownState();

  @override
  set setValue(T? value) {
    supportValue.value = value;
  }

  final List<DropdownMenuItem<T>> items;
  final BoringSupportValue<T> supportValue = BoringSupportValue();
}

class _BoringDropdownState<T> extends BoringFieldState<BoringDropdown<T>> {
  bool error = false;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      alignment: Alignment.bottomCenter,
      decoration: InputDecoration(
        errorText: error ? 'Required' : null,
      ),
      hint: Text(widget.title ?? ''),
      value: widget.controller.getValue(),
      onChanged: (T? newValue) {
        setState(() {
          widget.setValue = newValue;
        });
        widget.onChanged?.call(newValue);
      },
      items: widget.items,
    );
  }

  @override
  void validate() {
    setState(() {
      error = widget.required ? widget.controller.getValue() == null : false;
    });
  }

  @override
  void reset() {
    setState(() {
      error = false;
      widget.setValue = widget.initialValue;
    });
  }
}
