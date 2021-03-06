import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_field_with_validation.dart';
import 'package:flutter/material.dart';

class BoringTextField extends StatefulWidget
    implements BoringFieldWithValidation<String> {
  const BoringTextField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.validator,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  }) : super(key: key);

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final String? initialValue;
  @override
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  @override
  final BoringFieldController<String>? controller;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  @override
  BoringTextField copyWithController() {
    return BoringTextField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      validator: validator,
      controller: controller ?? BoringFieldController<String>(),
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );
  }

  @override
  State<BoringTextField> createState() => _BoringTextFieldState();
}

class _BoringTextFieldState extends State<BoringTextField>
    implements BoringFieldStateWithValidation<String> {
  final textController = TextEditingController();
  String? savedError;
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue;
    updateValid();
    textController.text = widget.controller?.value ?? '';

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldReset ?? false) &&
          !(widget.controller?.isResetting ?? false)) {
        reset();
      }
    });

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldGetValid ?? false) &&
          !(widget.controller?.isGettingValid ?? false)) {
        updateValid();
      }
    });

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldValidate ?? false) &&
          !(widget.controller?.isValidating ?? false)) {
        validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      onChanged: (v) {
        setState(() {
          errorText = null;
        });
        widget.controller?.value = v;
        updateValid();
      },
      decoration: InputDecoration(
        label: Text(widget.label),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void reset() {
    setState(() {
      errorText = null;
    });
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    widget.controller?.value = widget.initialValue;
    updateValid();
    textController.text = widget.controller?.value ?? '';
    widget.controller?.isResetting = false;
  }

  @override
  void updateValid() {
    savedError = widget.validator?.call(widget.controller?.value);
    widget.controller?.valid = savedError == null;
  }

  @override
  void validate() {
    widget.controller?.shouldValidate = false;
    widget.controller?.isValidating = true;
    setState(() {
      errorText = savedError;
    });
    widget.controller?.isValidating = false;
  }
}
