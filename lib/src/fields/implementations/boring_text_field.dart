import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringTexField extends BoringField<String> {
  BoringTexField(
      {Key? key,
      required BoringFieldController controller,
      required String jsonKey,
      this.defaultValue = "",
      this.onValueChanged,
      this.validator})
      : super(boringFieldController: controller, key: key, jsonKey: jsonKey);

  final TextEditingController textController = TextEditingController();
  final String defaultValue;
  @override
  final String? Function(String)? validator;
  final void Function(String)? onValueChanged;

  @override
  String get value => textController.text;

  @override
  void onChanged(String value) {
    onValueChanged?.call(value);
  }

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringTexField> createState() => _BoringTextFieldState();

  @override
  set setValue(String value) {
    textController.text = value;
  }
}

class _BoringTextFieldState extends BoringFieldState<BoringTexField> {
  String? errorText;

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(errorText: errorText),
      controller: widget.textController,
      onChanged: (value) => widget.onChanged(value),
    );
  }

  @override
  void reset() {
    widget.textController.text = widget.defaultValue;
  }
}
