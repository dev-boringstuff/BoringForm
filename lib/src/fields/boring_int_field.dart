import 'package:boring_form_builder/src/boring_field.dart';
import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:boring_form_builder/src/boring_field_with_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoringIntField extends StatefulWidget
    implements BoringFieldWithValidation<int> {
  const BoringIntField(
      {Key? key,
      required this.jsonKey,
      required this.label,
      this.helperText,
      this.initialValue,
      this.controller,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.validator})
      : super(key: key);

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final int? initialValue;
  @override
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  @override
  final BoringFieldController<int>? controller;

  @override
  BoringIntField copyWithController() {
    return BoringIntField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      validator: validator,
      controller: controller ?? BoringFieldController<int>(),
    );
  }

  @override
  State<BoringIntField> createState() => _BoringIntFieldState();
}

class _BoringIntFieldState extends State<BoringIntField>
    implements BoringFieldState<String> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue;
    textController.text = widget.controller?.value != null
        ? widget.controller!.value.toString()
        : '';

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldReset ?? false) &&
          !(widget.controller?.isResetting ?? false)) {
        reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      validator: widget.validator,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (v) => widget.controller?.value = int.tryParse(v),
      decoration: InputDecoration(
        label: Text(widget.label),
        helperText: widget.helperText,
      ),
    );
  }

  @override
  void reset() {
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    widget.controller?.value = widget.initialValue;
    textController.text = widget.controller?.value != null
        ? widget.controller!.value.toString()
        : '';
    widget.controller?.isResetting = false;
  }
}
