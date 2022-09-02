import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringDoubleField extends BoringField<double> {
  BoringDoubleField({
    super.initialValue,
    super.validator,
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
  double? get value => supportValue.value;

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringDoubleField, double> createState() =>
      _BoringTextFieldState();

  @override
  set setValue(double? value) {
    controller.setValue(value);
  }

  final BoringSupportValue<double> supportValue = BoringSupportValue();
}

class _BoringTextFieldState
    extends BoringFieldState<BoringDoubleField, double> {
  final TextEditingController textController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
        widget.supportValue.value = double.tryParse(value.replaceAll(',', '.'));
        widget.onChanged?.call(double.tryParse(value.replaceAll(',', '.')));
      },
      decoration: InputDecoration(
        label: Text(widget.title ?? ''),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void setValue(double? newValue) {
    widget.supportValue.value = newValue;
    textController.text = newValue != null ? newValue.toString() : '';
  }

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
    if (widget.value == null && textController.text != '') {
      setState(() {
        errorText = 'Invalid number';
      });
    }
  }

  @override
  void reset() {
    textController.text = widget.initialValue?.toString() ?? '';
  }
}
