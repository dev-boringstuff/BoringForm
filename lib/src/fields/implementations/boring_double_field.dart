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

  final TextEditingController textController = TextEditingController();

  @override
  double? get value => double.tryParse(textController.text);

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringDoubleField> createState() => _BoringTextFieldState();

  @override
  set setValue(double? value) {
    textController.text = value.toString();
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringDoubleField> {
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
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
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
    if (widget.value == null && widget.textController.text != '') {
      setState(() {
        errorText = 'Invalid number';
      });
    }
  }

  @override
  void reset() {
    widget.textController.text = widget.initialValue?.toString() ?? '';
  }
}
