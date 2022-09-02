import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoringIntField extends BoringField<int> {
  BoringIntField({
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
  int? get value => supportValue.value;

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringIntField, int> createState() =>
      _BoringTextFieldState();

  @override
  set setValue(int? value) {
    controller.setValue(value);
  }

  final BoringSupportValue<int> supportValue = BoringSupportValue();
}

class _BoringTextFieldState extends BoringFieldState<BoringIntField, int> {
  String? errorText;
  final TextEditingController textController = TextEditingController();

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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
        widget.supportValue.value = int.tryParse(value);
        widget.onChanged?.call(int.tryParse(value));
      },
      decoration: InputDecoration(
        label: Text(widget.title ?? ''),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void setValue(int? newValue) {
    widget.supportValue.value = newValue;
    textController.text = newValue != null ? newValue.toString() : '';
  }

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  void reset() {
    textController.text = widget.initialValue?.toString() ?? '';
  }
}
