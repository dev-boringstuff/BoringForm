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
  int? get value => int.tryParse(textController.text);

  @override
  bool get isValid => (validator != null)
      ? validator?.call(value?.toString() ?? '') == null
      : true;
  @override
  BoringFieldState<BoringIntField> createState() => _BoringTextFieldState();

  @override
  set setValue(int? value) {
    textController.text = value.toString();
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringIntField> {
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        setState(() {
          errorText = null;
        });
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
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value?.toString() ?? '');
    });
  }

  @override
  void reset() {
    widget.textController.text = widget.initialValue?.toString() ?? '';
  }
}
